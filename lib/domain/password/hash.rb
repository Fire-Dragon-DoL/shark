require "securerandom"

module Domain
  module Password
    module Sample
      def self.default
        "apassword"
      end

      def self.random
        SecureRandom.base64(32)
      end
    end

    def self.pepper
      Rails.application.credentials.password[:pepper]
    end

    def self.hash(password)
    end

    def self.encrypt(password, key = pepper)
      fixed_size_key = Digest::SHA256.digest(key)
      crypt = ::ActiveSupport::MessageEncryptor.new(fixed_size_key)
      crypt.encrypt_and_sign(password)
    end

    def self.decrypt(password, key = pepper)
      fixed_size_key = Digest::SHA256.digest(key)
      crypt = ::ActiveSupport::MessageEncryptor.new(fixed_size_key)
      crypt.decrypt_and_verify(password)
    end

    def self.secure_compare(a, b)
      return false if a.blank? || b.blank? || a.bytesize != b.bytesize
      l = a.unpack "C#{a.bytesize}"

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end

    class Hash
      def call(password)
        hashed = Password.hash(password)
        Password.encrypt(password)
      end

      def self.call(password)
        instance = new
        instance.(password)
      end
    end
  end
end
