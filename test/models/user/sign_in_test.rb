# frozen_string_literal: true

require 'test_helper'

module User
  class SignInTest < ActiveSupport::TestCase
    test 'With username and password non-empty is valid' do
      username = SignIn::Sample.name
      password = SignIn::Sample.password
      params = { name: username, password: password }.with_indifferent_access

      sign_in = SignIn.build(params)

      assert sign_in.valid?
    end

    test 'With username and empty password is invalid' do
      username = SignIn::Sample.name
      password = SignIn::Sample.empty_password
      params = { name: username, password: password }.with_indifferent_access

      sign_in = SignIn.build(params)

      assert_not sign_in.valid?
      assert sign_in.errors.details[:password].find do |msg|
        msg[:error] == :blank
      end
    end

    test 'With password and empty username is invalid' do
      username = SignIn::Sample.empty_name
      password = SignIn::Sample.password
      params = { name: username, password: password }.with_indifferent_access

      sign_in = SignIn.build(params)

      assert_not sign_in.valid?
      assert sign_in.errors.details[:name].find do |msg|
        msg[:error] == :blank
      end
    end
  end
end
