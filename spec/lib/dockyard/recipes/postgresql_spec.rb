require "spec_helper"
require "dockyard/recipes/postgresql"

describe "Dockyard::Recipes::Postgresql" do
  subject(:clazz) { Dockyard::Recipes::Postgresql }

  it { clazz.new.version.should eq("9.2.4") }
end

