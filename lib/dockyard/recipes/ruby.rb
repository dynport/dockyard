require "dockyard/recipes/base"

module Dockyard
  module Recipes
    class Ruby < Base
      def url
        "http://ftp.ruby-lang.org/pub/ruby/#{minor_version}/ruby-#{@version}.tar.gz"
      end

      def required_packages
        %w(libyaml-dev libxml2-dev libxslt1-dev libreadline-dev libssl-dev zlib1g-dev)
      end

      def configure_cmd
        "cd /tmp/#{name} && ./configure --disable-install-doc"
      end
    end
  end
end
