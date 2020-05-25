require 'domain/password'
require 'domain/user/put'

module Domain
  module User
    class Get
      NS = Put::NS

      def self.call(name)
        instance = new
        instance.(name)
      end

      def call(name)
        DB::Repo.get("#{DB::NS}:#{NS}:#{name}")
      end

      class Substitute
        attr_accessor :username
        attr_accessor :password
        attr_accessor :digest

        def initialize(username, password)
          @username = username
          @password = password
          @digest ||= Password::Digest.new
        end

        def call(name)
          return nil if username != name
          digested_password
        end

        def digested_password
          digest.(password)
        end
      end
    end
  end
end
