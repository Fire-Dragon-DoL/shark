# frozen_string_literal: true

require 'test_helper'
require 'domain/user/put'
require 'domain/password'
require 'domain/username'

module Domain
  module User
    class PutTest < ActiveSupport::TestCase
      test 'With unique username is successful' do
        username = Username::Sample.random
        password = Password::Sample.default

        is_put = Put.(username, password)

        assert is_put
      end

      test 'With duplicate username fails' do
        username = Username::Sample.random
        password = Password::Sample.default

        prior_is_put = Put.(username, password)
        is_put = Put.(username, password)

        assert prior_is_put != is_put
        refute is_put
      end
    end
  end
end
