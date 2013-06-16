require "dockyard/recipes/base"

module Dockyard
  module Recipes
    class Riak < Base
      def url
        "http://downloads.basho.com.s3-website-us-east-1.amazonaws.com/riak/#{minor_version}/#{version}/riak-#{version}.tar.gz"
      end

      def required_packages
        %w(git-core build-essential curl erlang-nox erlang-reltool)
      end

      def configure_cmd
        nil
      end

      def install_cmd
        nil
      end

      def build_cmd
        "cd /tmp/#{name} && make rel"
      end

      def run_cmd
        [
          %(ip_addr=$(#{ip_addr_cmd})),
          %(sed "s/127\.0\.0\.1/$ip_addr/" -i #{release_path}/etc/app.config),
          %(sed "s/127\.0\.0\.1/$ip_addr/" -i #{release_path}/etc/vm.args),
          %(WAIT_FOR_ERLANG=60 #{release_path}/bin/riak start),
          %(bash -c "if [[ $RIAK_JOIN_HOST ]]; then #{release_path}/bin/riak-admin cluster join $RIAK_JOIN_HOST && #{release_path}/bin/riak-admin cluster commit; fi"),
          %(tail -F #{release_path}/log/console.log)
        ].join(" && ")
      end

      def expose_ports
        [8087, 8098, 8099]
      end

      def release_path
        "/tmp/#{name}/rel/riak"
      end

      def ip_addr_cmd
        %(ip addr | grep "inet " | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -d '/' -f 1)
      end

      # def install_cmd
      # end

      # vm.args
      # -name riak@127.0.0.1
      # -setcookie riak
      # +K true
      # +A 64
      # +W w
      # -env ERL_MAX_PORTS 4096
      # -env ERL_FULLSWEEP_AFTER 0
      # -env ERL_CRASH_DUMP ./log/erl_crash.dump
      #
      # 
    end
  end
end
