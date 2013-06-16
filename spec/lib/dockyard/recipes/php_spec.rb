require "spec_helper"
require "dockyard/recipes/php"

describe "Dockyard::Recipes::PHP" do
  subject(:clazz) { Dockyard::Recipes::PHP }

  describe "#instance" do
    subject(:instance) { clazz.new("5.3.26") }
    it { subject.url.should be_kind_of(String) }
  end
end

