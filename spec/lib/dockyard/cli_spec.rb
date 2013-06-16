require "spec_helper"
require "dockyard/cli"

describe "Dockyard::CLI" do
  subject(:clazz) { Dockyard::CLI }
  it { should_not be_nil }

  describe "#instance" do
    subject(:instance) { Dockyard::CLI.new(%w(build ruby)) }

    describe "#to_dockerfile" do
      subject(:str) { instance.to_dockerfile }

      it { should be_kind_of(String) }
      it { should_not include("FROM") }
      it { should include("RUN apt-get install -y build-essential curl") }

      describe "with from set" do
        subject(:str) do
          instance = Dockyard::CLI.new(%w(build ruby -f ubuntu:12.04))
          instance.to_dockerfile
        end

        it { should start_with("FROM ubuntu:12.04") }
        it { should end_with("\n") }
      end

      describe "with version set" do
        subject(:str) do
          instance = Dockyard::CLI.new(%w(build ruby -f ubuntu:12.04 -v 1.9.3-p0))
          instance.to_dockerfile
        end

        it { should start_with("FROM ubuntu:12.04") }
        it { should end_with("\n") }
        it { should include("RUN cd /tmp/ruby-1.9.3-p0 && make") }
      end
    end
  end
end
