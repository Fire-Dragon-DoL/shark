require 'test_helper'
require 'domain/password/hash'

module Domain
  module Password
    class EncryptTest < ActiveSupport::TestCase
      test "Password encryption is symmetrical" do
        password = Password::Sample.default

        pass_hash = Password.encrypt(password)
        decrypted_pass = Password.decrypt(pass_hash)

        assert password == decrypted_pass
      end

      test "Encrypted password differs from unencrypted" do
        password = Password::Sample.default

        pass_hash = Password.encrypt(password)

        assert pass_hash != password
      end

      test "Decryption with incorrect key raises error" do
        password = Password::Sample.default
        pepper = "invalid"

        pass_hash = Password.encrypt(password)

        assert_raise ActiveSupport::MessageEncryptor::InvalidMessage do
          Password.decrypt(pass_hash, pepper)
        end
      end
    end
  end
end
