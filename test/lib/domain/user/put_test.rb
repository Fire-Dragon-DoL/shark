require 'test_helper'
require 'domain/user/put'
require 'domain/password'
require 'securerandom'

module Domain
  module User
    class PutTest < ActiveSupport::TestCase
      test "With unique username is successful" do
        username = SecureRandom.uuid
        password = Password::Sample.default

        is_put = Put.(username, password)

        assert is_put
      end

      test "With duplicate username fails" do
        username = SecureRandom.uuid
        password = Password::Sample.default

        Put.(username, password)
        is_put = Put.(username, password)

        refute is_put
      end
    end
  end
end
