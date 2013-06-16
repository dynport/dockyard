require "dockyard/recipes/base"

module Dockyard
  module Recipes
    class PostgreSQL < Base
      def url
        "http://ftp.postgresql.org/pub/source/v#{version}/postgresql-#{version}.tar.gz"
      end

      def configure_cmd
        "cd /tmp/#{name} && ./configure --with-libxml --with-python --with-libxslt --with-openssl"
      end

      def required_packages
        %w(libxslt1-dev libxml2-dev python-dev libreadline-dev bison flex)
      end
    end
  end
end
