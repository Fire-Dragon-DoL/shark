# frozen_string_literal: true

require 'test_helper'
require 'domain/user/get'
require 'domain/password'
require 'domain/username'

module Domain
  module User
    class Get
      class SubstituteTest < ActiveSupport::TestCase
        test 'With username matching configured returns digested password' do
          username = Username::Sample.random
          password = Password::Sample.default
          get = Substitute.new(username, password)

          digested_pass = get.(username)
          is_matching_pass = Password::Match.(digested_pass, password)

          assert is_matching_pass
        end

        test 'With username different from configured returns nil' do
          username = Username::Sample.random
          password = Password::Sample.default
          other_username = Username::Sample.default
          get = Substitute.new(username, password)

          digested_pass = get.(other_username)

          assert digested_pass.nil?
        end
      end
    end
  end
end
