require "spec_helper"
require "dockyard/recipes/base"

describe "Dockyard::Recipes::Base" do
  subject(:clazz) { Dockyard::Recipes::Base }
  it { should_not be_nil }

  describe "#instance" do
    subject(:instance) { clazz.new("HEAD") }

    describe "to_dockerfile" do
      subject(:file) do
        instance.from "ubuntu:12.04"
        instance.run "echo hello world"

        instance.to_dockerfile
      end

      it { should include("FROM ubuntu:12.04") }
      it { should include("echo hello world") }
    end

    describe "#write_file" do
      subject(:str) { instance.write_file("/etc/passwd", "hello\nworld") }
      it { should be_kind_of(String) }
      it { should eq("echo aGVsbG8Kd29ybGQ= > /etc/passwd") }
    end

    describe "#enable_universe" do
      subject(:str) { instance.enable_universe_cmd }

      it { should be_kind_of(String) }
      it { should start_with("sed") }
    end

    describe "#install_required_packages_cmd" do
      subject(:str) do
        instance.stub(:required_packages) { ["curl"] }
        instance.install_required_packages_cmd
      end
      it { should be_kind_of(String) }

      describe "with no packages selected" do
        subject(:str) do
          instance.stub(:required_packages) { [] }
          instance.install_required_packages_cmd
        end
        it { should be_nil }
      end
    end

    describe "#download_url_cmd" do
      subject(:cmd) do
        instance.download_url_cmd("http://127.0.0.1/test", "/path/to/download")
      end

      it { should be_kind_of(String) }
      it { should start_with("mkdir -p /path/to") }
      it { should include("curl -s -o /path/to/download.tmp http://127.0.0.1/test") }
      it { should include("mv /path/to/download.tmp /path/to/download") }

    end
  end
end
