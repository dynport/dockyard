require "dockyard/recipes/base"

module Dockyard
  module Recipes
    class Redis < Base
      def url
        "http://redis.googlecode.com/files/redis-#{version}.tar.gz"
      end

      def configure_cmd
        # noop
      end

      def required_packages
        []
      end

      def default_version
        "2.6.13"
      end
    end
  end
end
