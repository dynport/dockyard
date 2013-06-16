require "set"

module Dockyard
  module Recipes
    class Base
      class << self
        def inherited(clazz)
          all_names[clazz.name.split("::").last.downcase] = clazz
        end

        def all_names
          @all_names ||= {}
        end
      end

      def initialize(version = nil)
        @version = version
      end

      def version
        @version || default_version
      end

      def default_version
        raise "implement me"
      end

      def to_s
        commands.join("\n")
      end

      def commands
        [
          enable_universe_cmd,
          "apt-get install -y build-essential curl",
          download_cmd,
          install_required_packages_cmd,
          extract_cmd,
          configure_cmd,
          build_cmd,
          install_cmd,
        ].flatten.compact
      end

      def download_url_cmd(url, local_path = nil)
        file_name = File.basename(url)
        local_path ||= "/tmp/#{file_name}"
        "mkdir -p #{File.dirname(local_path)} && curl -s -o #{local_path}.tmp #{url} && mv #{local_path}.tmp #{local_path}"
      end

      def download_cmd
        "curl -s -o /tmp/#{file_name}.tmp #{url} && mv /tmp/#{file_name}.tmp /tmp/#{file_name}"
      end

      def install_required_packages_cmd
        return nil if required_packages.empty?
        "DEBIAN_FRONTEND=noninteractive apt-get install -y #{required_packages.join(" ")}"
      end

      def extract_cmd
        "cd /tmp && tar xfz #{file_name}"
      end

      def name
        file_name.gsub(/\.tar\.gz$/, "")
      end

      def build_cmd
        "cd /tmp/#{name} && make"
      end

      def install_cmd
        "cd /tmp/#{name} && make install"
      end

      def file_name
        File.basename(url)
      end

      def minor_version
        version.split(".")[0,2].join(".")
      end

      [:from, :run, :env, :expose, :cmd].each do |name|
        define_method(name) do |*args|
          lines << "#{name.upcase} #{args.join(" ")}"
        end
      end

      def write_file(path, content)
        "echo #{encode64(content)} > #{path}"
      end

      def enable_universe_cmd
        %(sed 's/main$/universe main/' -i /etc/apt/sources.list && apt-get update && apt-get upgrade -y)
      end

      def encode64(raw)
        require "base64"
        Base64.encode64(raw).gsub("\n", "")
      end

      def to_dockerfile
        lines.join("\n")
      end

      def compile
        commands.each do |cmd|
          run cmd
        end
      end

      def lines 
        @lines ||= []
      end
    end
  end
end
