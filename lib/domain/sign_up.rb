require 'domain/password'
require 'domain/user/put'

module Domain
  class SignUp
    attr_accessor :put
    attr_accessor :digest

    def initialize
      @put ||= User::Put.new
      @digest ||= Password::Digest.new
    end

    def call(username, password)
      digested_pass = digest.(password)
      put.(username, digested_pass)
    end

    def self.call(username, password)
      instance = new
      instance.(username, password)
    end
  end
end
