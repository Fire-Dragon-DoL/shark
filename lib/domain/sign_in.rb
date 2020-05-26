require 'domain/password'
require 'domain/user/get'
require 'securerandom'

module Domain
  class SignIn
    attr_accessor :get
    attr_accessor :match

    def initialize
      @get = User::Get.new
      @match = Password::Match.new
    end

    def call(username, password)
      digested_pass = get.(username)

      return nil if digested_pass.nil?
      return nil unless match.(digested_pass, password)
      self.class.build_token
    end

    def self.call(username, password)
      instance = new
      instance.(username, password)
    end

    def self.build_token
      SecureRandom.urlsafe_base64(32)
    end
  end
end
