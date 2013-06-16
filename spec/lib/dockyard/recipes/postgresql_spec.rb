require "spec_helper"
require "dockyard/recipes/postgresql"

describe "Dockyard::Recipes::PostgreSQL" do
  subject(:clazz) { Dockyard::Recipes::PostgreSQL }

  it { clazz.new.version.should eq("9.2.4") }
end

