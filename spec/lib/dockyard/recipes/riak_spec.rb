require "spec_helper"
require "dockyard/recipes/riak"

describe "Dockyard::Recipes::Riak" do
  subject(:clazz) { Dockyard::Recipes::Riak }
  it { should_not be_nil }

  describe "#instance" do
    subject(:instance) { clazz.new("1.2.0") }

    it { subject.url.should be_kind_of(String) }
    it { subject.url.should eq("http://downloads.basho.com.s3-website-us-east-1.amazonaws.com/riak/1.2/1.2.0/riak-1.2.0.tar.gz") }

    it { subject.run_cmd.should include("riak start") }

  end
end
