require "spec_helper"
require "dockyard/recipes/memcached"

describe "Dockyard::Recipes::Memcached" do
  subject(:clazz) { Dockyard::Recipes::Memcached }
  it { clazz.new.version.should eq("1.4.15") }
end

