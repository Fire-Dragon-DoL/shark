# frozen_string_literal: true

require 'domain/username'
require 'domain/password'

module User
  class SignIn
    include ActiveModel::Validations

    attr_accessor :name
    attr_accessor :password

    validates :name,
              presence: true
    validates :password,
              presence: true

    def initialize(name, password)
      @name = name
      @password = password
    end

    def self.build(params)
      new(params[:name], params[:password])
    end

    module Sample
      def self.name
        ::Domain::Username::Sample.random
      end

      def self.password
        ::Domain::Password::Sample.default
      end

      def self.password_other
        ::Domain::Password::Sample.default + '2'
      end

      def self.empty_name
        ""
      end

      def self.empty_password
        ""
      end
    end
  end
end
