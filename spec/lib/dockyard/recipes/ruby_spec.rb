require "spec_helper"
require "dockyard/recipes/ruby"

describe "Dockyard::Recipes::Ruby" do
  subject(:clazz) { Dockyard::Recipes::Ruby }
  it { should_not be_nil }

  it { clazz.new.version.should eq("2.0.0-p195") }

  describe "#instance" do
    subject(:instance) { clazz.new("2.0.0-p195") }

    it { should_not be_nil }

    describe "enable_universe_cmd" do
      subject(:cmd) { instance.enable_universe_cmd }
      it { should be_kind_of(String) }
    end

    describe "#to_s" do
      subject(:str) { instance.to_s }
      it { should be_kind_of(String) }
      it { should include("build-essential") }
    end

    describe "#download_cmd" do
      subject(:cmd) { instance.download_cmd }
      it { should be_kind_of(String) }
      it { should start_with("curl -s -o /tmp/ruby-2.0.0-p195.tar.gz.tmp http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p195.tar.gz") }
    end

    describe "#url" do
      subject(:url) { instance.url }
      it { should be_kind_of(String) }
      it { should eq("http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p195.tar.gz") }
    end

    describe "#configure_cmd" do
      subject(:cmd) { instance.configure_cmd }
      it { should be_kind_of(String) }
      it { should eq("cd /tmp/ruby-2.0.0-p195 && ./configure --disable-install-doc") }
    end

    describe "#build_cmd" do
      subject(:cmd) { instance.build_cmd }
      it { should be_kind_of(String) }
      it { should start_with("cd /tmp/ruby-2.0.0-p195 && make") }
    end

    describe "#install_cmd" do
      subject(:cmd) { instance.install_cmd }
      it { should be_kind_of(String) }
      it { should start_with("cd /tmp/ruby-2.0.0-p195 && make install") }
    end

    describe "#required_packages" do
      subject(:packages) { instance.required_packages }
      it { should be_kind_of(Array) }
      it { should include("libyaml-dev") }
    end

    describe "#install_required_packages_cmd" do
      subject(:cmd) { instance.install_required_packages_cmd }
      it { should be_kind_of(String) }
      it { should start_with("DEBIAN_FRONTEND=noninteractive") }
    end

    describe "#extract_cmd" do
      subject(:cmd) { instance.extract_cmd }
      it { should start_with("cd /tmp && tar xfz ruby-2.0.0-p195.tar.gz") }
    end

    describe "#install_cmd" do
      subject(:cmd) { instance.install_cmd }
      it { should be_kind_of(String) }
    end
  end
end

