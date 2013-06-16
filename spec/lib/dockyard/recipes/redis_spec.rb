require "spec_helper"
require "dockyard/recipes/redis"

describe "Dockyard::Recipes::Redis" do
  subject(:clazz) { Dockyard::Recipes::Redis }

  it { clazz.new.version.should eq("2.6.13") }

  describe "#instance" do
    subject(:instance) { clazz.new("2.3.16") }

    it { subject.commands.should_not include(nil) }
  end
end

