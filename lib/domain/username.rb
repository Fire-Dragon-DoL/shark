# frozen_string_literal: true

require 'securerandom'

module Domain
  module Username
    module Sample
      def self.default
        'ausername'
      end

      def self.random
        SecureRandom.uuid
      end
    end
  end
end
