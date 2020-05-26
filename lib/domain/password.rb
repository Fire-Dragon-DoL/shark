# frozen_string_literal: true

require 'securerandom'

module Domain
  # OWASP Password Storage Cheat Sheet:
  # https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
  module Password
    module Sample
      def self.default
        'apassword'
      end

      def self.random
        SecureRandom.base64(32)
      end
    end

    def self.pepper
      Rails.application.credentials.password[:pepper]
    end

    # Extracted from Rails:
    # https://github.com/rails/rails/blob/34991a6ae2fc68347c01ea7382fa89004159e019/activemodel/lib/active_model/secure_password.rb#L100-L101
    # Bcrypt cost defaults to 12, satisfying OWASP recommendation
    def self.unsafe_hash(password)
      ::BCrypt::Password.create(password).to_s
    end

    def self.unsafe_hash_with_salt(password, salt)
      ::BCrypt::Engine.hash_secret(password, salt)
    end

    def self.load_hash(pass_hash)
      bcrypt_pass = ::BCrypt::Password.new(pass_hash)
      [bcrypt_pass.to_s, bcrypt_pass.salt]
    end

    # Encryption uses AES-256-GCM, satisfying OWASP recommendation
    def self.encrypt(password, key = pepper)
      fixed_size_key = ::Digest::SHA256.digest(key)
      crypt = ::ActiveSupport::MessageEncryptor.new(fixed_size_key)
      crypt.encrypt_and_sign(password)
    end

    def self.decrypt(password, key = pepper)
      fixed_size_key = ::Digest::SHA256.digest(key)
      crypt = ::ActiveSupport::MessageEncryptor.new(fixed_size_key)
      crypt.decrypt_and_verify(password)
    end

    # Extracted from Devise:
    # https://github.com/heartcombo/devise/blob/b52e642c0131f7b0d9f2dd24d8607a186f18223e/lib/devise.rb#L503-L512
    # Prevents timing attacks
    def self.fixed_time_compare(left, right)
      return false if left.blank? || right.blank? || left.bytesize != right.bytesize

      unpacked = left.unpack "C#{left.bytesize}"

      res = 0
      right.each_byte { |byte| res |= byte ^ unpacked.shift }
      res.zero?
    end

    class Digest
      def call(password)
        hashed = Password.unsafe_hash(password)
        Password.encrypt(hashed)
      end

      def self.call(password)
        instance = new
        instance.(password)
      end
    end

    class Match
      def call(digested_pass, plain_pass)
        decrypted_hash = Password.decrypt(digested_pass)
        digested_hash, digested_salt = Password.load_hash(decrypted_hash)

        plain_hash = Password.unsafe_hash_with_salt(plain_pass, digested_salt)

        Password.fixed_time_compare(digested_hash, plain_hash)
      end

      def self.call(digested_pass, plain_pass)
        instance = new
        instance.(digested_pass, plain_pass)
      end
    end
  end
end
