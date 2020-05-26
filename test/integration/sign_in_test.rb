# frozen_string_literal: true

require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest
  test 'With existing username and matching password is successful' do
    username = ::User::SignIn::Sample.name
    password = ::User::SignIn::Sample.password
    params = { name: username, password: password, password_confirmation: password }

    post users_url, params: params
    post sessions_url, params: params

    assert @response.status >= 200 && @response.status <= 299
  end

  test 'With existing username and incorrect password is unauthorized' do
    username = ::User::SignIn::Sample.name
    password = ::User::SignIn::Sample.password
    other_pass = ::User::SignIn::Sample.password_other
    params = { name: username, password: password, password_confirmation: password }
    invalid_params = { name: username, password: other_pass }

    post users_url, params: params
    post sessions_url, params: invalid_params

    assert @response.status == 401
  end

  test 'With missing username is unauthorized' do
    username = ::User::SignIn::Sample.name
    password = ::User::SignIn::Sample.password
    params = { name: username, password: password, password_confirmation: password }

    post sessions_url, params: params

    assert @response.status == 401
  end

  test 'With invalid username is unprocessable' do
    username = ::User::SignIn::Sample.empty_name
    password = ::User::SignIn::Sample.password
    params = { name: username, password: password, password_confirmation: password }

    post sessions_url, params: params

    assert @response.status == 422
  end

  test 'With invalid password is unprocessable' do
    username = ::User::SignIn::Sample.name
    password = ::User::SignIn::Sample.empty_password
    params = { name: username, password: password, password_confirmation: password }

    post sessions_url, params: params

    assert @response.status == 422
  end
end
