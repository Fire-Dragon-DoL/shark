# frozen_string_literal: true

require 'test_helper'
require 'domain/user/get'
require 'domain/sign_in'
require 'domain/username'
require 'domain/password'

module Domain
  class SignInTest < ActiveSupport::TestCase
    test 'With existing username and matching password is successful' do
      username = Username::Sample.random
      password = Password::Sample.default

      sign_in = SignIn.new
      sign_in.get = User::Get::Substitute.new(username, password)
      token = sign_in.(username, password)

      refute token.nil?
    end

    test 'With missing username fails' do
      username = Username::Sample.random
      password = Password::Sample.default
      other_username = Username::Sample.default

      sign_in = SignIn.new
      sign_in.get = User::Get::Substitute.new(other_username, password)
      token = sign_in.(username, password)

      assert token.nil?
    end

    test 'With existing username and incorrect password fails' do
      username = Username::Sample.random
      password = Password::Sample.default
      other_password = Password::Sample.random

      sign_in = SignIn.new
      sign_in.get = User::Get::Substitute.new(username, password)
      token = sign_in.(username, other_password)

      assert token.nil?
    end
  end
end
