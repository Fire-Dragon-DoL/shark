# frozen_string_literal: true

require 'test_helper'
require 'domain/password'

module Domain
  module Password
    class MatchTest < ActiveSupport::TestCase
      test 'Hashed password matches plain text password' do
        password = Password::Sample.default
        digest_pass = Password::Digest.(password)

        is_match = Password::Match.(digest_pass, password)

        assert is_match
      end

      test 'Hashed password does not match different plain text password' do
        password = Password::Sample.default
        other_password = Password::Sample.random
        digest_pass = Password::Digest.(password)

        is_match = Password::Match.(digest_pass, other_password)

        assert_not is_match
      end

      test 'Raises when both passwords are plain text' do
        password = Password::Sample.default

        assert_raise do
          Password::Match.(password, password)
        end
      end
    end
  end
end
