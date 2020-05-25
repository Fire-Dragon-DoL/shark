module Domain
  module User
    class Put
      NS = "user"

      def self.call(name, password)
        instance = new
        instance.(name, password)
      end

      def call(name, password)
        DB::Repo.setnx("#{DB::NS}:#{NS}:#{name}", password)
      end
    end
  end
end
