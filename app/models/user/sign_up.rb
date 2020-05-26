# frozen_string_literal: true

require 'domain/username'
require 'domain/password'

module User
  class SignUp
    include ActiveModel::Validations

    attr_accessor :name
    attr_accessor :password
    attr_accessor :password_confirmation

    validates :name,
              presence: true,
              length: { minimum: 1, maximum: 255 }
    validates :password,
              presence: true,
              length: { minimum: 8, maximum: 32 },
              confirmation: true
    validates :password_confirmation,
              presence: true,
              length: { minimum: 8, maximum: 32 }

    def initialize(name, password, password_confirmation)
      @name = name
      @password = password
      @password_confirmation = password_confirmation
    end

    def self.build(params)
      new(params[:name], params[:password], params[:password_confirmation])
    end

    module Sample
      def self.name
        ::Domain::Username::Sample.default
      end

      def self.password
        ::Domain::Password::Sample.default
      end

      def self.password_other
        ::Domain::Password::Sample.default + '2'
      end

      def self.too_short_name
        ''
      end

      def self.too_long_name
        'a' * 256
      end

      def self.too_short_password
        'a' * 7
      end

      def self.too_long_password
        'a' * 33
      end
    end
  end
end
