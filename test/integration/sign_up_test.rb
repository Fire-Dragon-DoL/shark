# frozen_string_literal: true

require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test 'With valid username, password and password confirmation is successful' do
    username = ::User::SignUp::Sample.name
    password = ::User::SignUp::Sample.password
    params = { name: username, password: password, password_confirmation: password }

    post users_url, params: params

    assert @response.status >= 200 && @response.status <= 299
  end

  test 'With same username it conflicts' do
    username = ::User::SignUp::Sample.name
    password = ::User::SignUp::Sample.password
    params = { name: username, password: password, password_confirmation: password }

    post users_url, params: params
    prior_status = @response.status
    post users_url, params: params

    assert prior_status != @response.status
    assert prior_status >= 200 && prior_status <= 299
    assert @response.status == 409
  end

  test 'With invalid username it errors' do
    username = ::User::SignUp::Sample.too_short_name
    password = ::User::SignUp::Sample.password
    params = { name: username, password: password, password_confirmation: password }

    post users_url, params: params

    assert @response.status == 422
  end

  test 'With invalid password it errors' do
    username = ::User::SignUp::Sample.name
    password = ::User::SignUp::Sample.too_short_password
    params = { name: username, password: password, password_confirmation: password }

    post users_url, params: params

    assert @response.status == 422
  end
end
