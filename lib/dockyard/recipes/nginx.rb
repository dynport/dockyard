require "dockyard/recipes/base"

module Dockyard
  module Recipes
    class Nginx < Base
      def url
        "http://nginx.org/download/nginx-#{version}.tar.gz"
      end

      def required_packages
        %w(unzip libpcre3 libpcre3-dev libssl-dev libpcrecpp0 zlib1g-dev libgd2-xpm-dev)
      end

      def default_version
        "1.4.1"
      end

      def configure_cmd
        [
          download_url_cmd(syslog_config_url, syslog_patch_path + "/config"),
          download_url_cmd(syslog_patch_url, syslog_patch_path + "/" + syslog_patch_name),
          "cd /tmp/#{name} && patch -p1 < #{syslog_patch_path}/#{syslog_patch_name}",
          "cd /tmp/#{name} && ./configure --with-http_ssl_module --with-http_spdy_module --with-http_gzip_static_module --with-http_stub_status_module --add-module=/tmp/nginx_syslog_patch"
        ].flatten
      end

      def syslog_patch_path
        "/tmp/nginx_syslog_patch"
      end

      def syslog_config_url
        "https://raw.github.com/yaoweibin/nginx_syslog_patch/master/config"
      end

      def syslog_patch_url
        "https://raw.github.com/yaoweibin/nginx_syslog_patch/master/#{syslog_patch_name}"
      end

      def syslog_patch_name
        "syslog_#{syslog_patch_version}.patch"
      end

      def syslog_patch_version
        if version[/^1\.4/]
          "1.3.14"
        else
          "1.2.7"
        end
      end
    end
  end
end
