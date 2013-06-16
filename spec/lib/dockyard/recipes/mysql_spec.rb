require "spec_helper"
require "dockyard/recipes/mysql"

describe "Dockyard::Recipes::MySQL" do
  subject(:clazz) { Dockyard::Recipes::MySQL }
  it { clazz.new.version.should eq("5.6.11") }
end

