require "spec_helper"
require "dockyard/recipes/mysql"

describe "Dockyard::Recipes::Mysql" do
  subject(:clazz) { Dockyard::Recipes::Mysql }
  it { clazz.new.version.should eq("5.6.11") }
end

