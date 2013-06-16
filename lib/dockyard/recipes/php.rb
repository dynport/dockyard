module Dockyard
  module Recipes
    class PHP < Base
      def default_version
        "5.3.26"
      end

      def url
        "http://de1.php.net/distributions/php-#{version}.tar.gz"
      end

      def required_packages
        %w(libxml2-dev libexif-dev libzip-dev libpng-dev libmysqlclient-dev libjpeg-dev libpng-dev libfreetype6-dev file)
      end

      def configure_cmd
        "cd /tmp/#{name} && ./configure --with-zlib --with-mysql --with-mysqli --with-exif --with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-fpm"
      end
    end
  end
end
