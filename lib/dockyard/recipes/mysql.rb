require "dockyard/recipes/base"

module Dockyard
  module Recipes
    class MySQL < Base
      def url
        "http://cdn.mysql.com/Downloads/MySQL-#{minor_version}/mysql-#{version}.tar.gz"
      end

      def required_packages
        %w(libncurses5 libncurses5-dev cmake)
      end

      def configure_cmd
        "cd /tmp/#{name} && cmake ."
      end

      def default_version
        "5.6.11"
      end
    end
  end
end
