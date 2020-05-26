# frozen_string_literal: true

require 'test_helper'
require 'domain/password'

module Domain
  module Password
    class UnsafeHashTest < ActiveSupport::TestCase
      test 'Password hash differs from original data' do
        password = Password::Sample.default

        pass_hash = Password.unsafe_hash(password)

        assert pass_hash != password
      end

      test 'Hashing different passwords returns different data' do
        password = Password::Sample.default
        other_password = Password::Sample.random

        pass_hash = Password.unsafe_hash(password)
        other_hash = Password.unsafe_hash(other_password)

        assert pass_hash != other_hash
      end
    end
  end
end
