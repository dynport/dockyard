require "spec_helper"
require "dockyard/recipes/nginx"

describe "Dockyard::Recipes::Nginx" do
  subject(:clazz) { Dockyard::Recipes::Nginx }

  describe "#instance" do
    subject(:instance) { clazz.new("1.4.1") }

    describe "#to_s" do
      subject(:str) { instance.to_s }

      it { should be_kind_of(String) }
    end

    describe "#commands" do
      subject(:commands) { instance.commands }
      it { should be_kind_of(Array) }

      it { should include("mkdir -p /tmp/nginx_syslog_patch && curl -s -o /tmp/nginx_syslog_patch/config.tmp https://raw.github.com/yaoweibin/nginx_syslog_patch/master/config && mv /tmp/nginx_syslog_patch/config.tmp /tmp/nginx_syslog_patch/config") }
    end
  end
end

