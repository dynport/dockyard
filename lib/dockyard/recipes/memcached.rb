require "dockyard/recipes/base"

module Dockyard
  module Recipes
    class Memcached < Base
      def url
        "http://memcached.googlecode.com/files/memcached-#{version}.tar.gz"
      end

      def configure_cmd
        "cd /tmp/#{name} && ./configure"
      end

      def required_packages
        %w(libevent-dev)
      end
    end
  end
end
