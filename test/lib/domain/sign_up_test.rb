# frozen_string_literal: true

require 'test_helper'
require 'domain/sign_up'
require 'domain/username'
require 'domain/password'

module Domain
  class SignUpTest < ActiveSupport::TestCase
    test 'With unique username is successful' do
      username = Username::Sample.random
      password = Password::Sample.default

      is_signed_up = SignUp.(username, password)

      assert is_signed_up
    end

    test 'With duplicate username fails' do
      username = Username::Sample.random
      password = Password::Sample.default

      prior_is_signed_up = SignUp.(username, password)
      is_signed_up = SignUp.(username, password)

      assert prior_is_signed_up != is_signed_up
      refute is_signed_up
    end
  end
end
