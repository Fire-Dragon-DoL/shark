require 'test_helper'

module User
  class SignUpTest < ActiveSupport::TestCase
    test "With password and password confirmation matching is valid" do
      username = SignUp::Sample.name
      password = SignUp::Sample.password
      params = {
        name: username, password: password, password_confirmation: password
      }.with_indifferent_access

      sign_up = SignUp.build(params)

      assert sign_up.valid?
    end

    test "With password and password confirmation different is invalid" do
      username = SignUp::Sample.name
      password = SignUp::Sample.password
      other_pass = SignUp::Sample.password_other
      params = {
        name: username, password: password, password_confirmation: other_pass
      }.with_indifferent_access

      sign_up = SignUp.build(params)

      refute sign_up.valid?
      assert sign_up.errors.details[:password].find do |msg|
        msg[:error] == :confirmation
      end
    end

    test "With username nil is invalid" do
      username = nil
      password = SignUp::Sample.password
      params = {
        name: username, password: password, password_confirmation: password
      }.with_indifferent_access

      sign_up = SignUp.build(params)

      refute sign_up.valid?
      assert sign_up.errors.details[:name].find do |msg|
        msg[:error] == :blank
      end
    end

    test "With username too short is invalid" do
      username = SignUp::Sample.too_short_name
      password = SignUp::Sample.password
      params = {
        name: username, password: password, password_confirmation: password
      }.with_indifferent_access

      sign_up = SignUp.build(params)

      refute sign_up.valid?
      assert sign_up.errors.details[:name].find do |msg|
        msg[:error] == :too_short
      end
    end

    test "With username too long is invalid" do
      username = SignUp::Sample.too_long_name
      password = SignUp::Sample.password
      params = {
        name: username, password: password, password_confirmation: password
      }.with_indifferent_access

      sign_up = SignUp.build(params)

      refute sign_up.valid?
      assert sign_up.errors.details[:name].find do |msg|
        msg[:error] == :too_long
      end
    end

    test "With password too short is invalid" do
      username = SignUp::Sample.name
      password = SignUp::Sample.too_short_password
      params = {
        name: username, password: password, password_confirmation: password
      }.with_indifferent_access

      sign_up = SignUp.build(params)

      refute sign_up.valid?
      assert sign_up.errors.details[:password].find do |msg|
        msg[:error] == :too_short
      end
    end

    test "With password too long is invalid" do
      username = SignUp::Sample.name
      password = SignUp::Sample.too_long_password
      params = {
        name: username, password: password, password_confirmation: password
      }.with_indifferent_access

      sign_up = SignUp.build(params)

      refute sign_up.valid?
      assert sign_up.errors.details[:password].find do |msg|
        msg[:error] == :too_short
      end
    end
  end
end
