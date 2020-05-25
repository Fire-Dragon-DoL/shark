require 'test_helper'
require 'domain/sign_up'
require 'domain/user/get'
require 'domain/password'
require 'domain/username'

module Domain
  module User
    class GetTest < ActiveSupport::TestCase
      test "With existing username returns digested password" do
        username = Username::Sample.random
        password = Password::Sample.default

        SignUp.(username, password)
        digested_pass = Get.(username)
        is_matching_pass = Password::Match.(digested_pass, password)

        assert is_matching_pass
      end

      test "With missing username returns nil" do
        username = Username::Sample.random

        digested_pass = Get.(username)

        assert digested_pass.nil?
      end
    end
  end
end
