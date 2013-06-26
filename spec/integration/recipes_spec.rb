require "spec_helper"
require "anywhere/ssh"
$:.push(File.expand_path("../../../lib", __FILE__))

describe "Recipes spec", :integration do
  before(:all) do
    host = ENV["DOCKYARD_TEST_HOST"]
    raise "DOCKYARD_TEST_HOST must be set" if host.nil?
    user = ENV["DOCKYARD_TEST_USER"] || "vagrant"
    @ssh = Anywhere::SSH.new(host, user)
  end

  before do
    # @ssh.logger.stub(:debug) { }
  end

  def build_dockerfile(recipe)
    lines = ["FROM ubuntu:12.04"]
    lines += recipe.commands.map { |l| "RUN #{l}" }
    lines += ["EXPOSE #{recipe.expose_ports.join(" ")}"] if recipe.respond_to?(:expose_ports)
    lines += ["CMD #{recipe.run_cmd}"] if recipe.respond_to?(:run_cmd)
    lines.join("\n") + "\n"
  end

  it "should install nginx", :wip do
    require "dockyard/recipes/nginx"
    recipe = Dockyard::Recipes::Nginx.new("1.4.1")
    @ssh.execute("docker build -t dockyard:nginx -", build_dockerfile(recipe))
  end

  it "should install redis", :wip do
    require "dockyard/recipes/redis"
    recipe = Dockyard::Recipes::Redis.new("2.6.13")
    @ssh.execute("docker build -t dockyard:redis -", build_dockerfile(recipe))
  end

  it "should install ruby" do
    require "dockyard/recipes/ruby"
    recipe = Dockyard::Recipes::Ruby.new("2.0.0-p195")
    @ssh.execute("docker build -t dockyard:ruby -", build_dockerfile(recipe))
  end

  it "should install postgresql" do
    require "dockyard/recipes/postgresql"
    recipe = Dockyard::Recipes::Postgresql.new("9.2.4")
    @ssh.execute("docker build -t dockyard:postgresql -", build_dockerfile(recipe))
  end

  it "should install memcached" do
    require "dockyard/recipes/memcached"
    recipe = Dockyard::Recipes::Memcached.new("1.4.15")
    @ssh.execute("docker build -t dockyard:memcached -", build_dockerfile(recipe))
  end

  it "should install php" do
    require "dockyard/recipes/php"
    recipe = Dockyard::Recipes::PHP.new("5.3.26")
    @ssh.execute("docker build -t dockyard:php -", build_dockerfile(recipe))
  end

  it "should install mysql" do
    require "dockyard/recipes/mysql"
    recipe = Dockyard::Recipes::Mysql.new("5.6.11")
    @ssh.execute("docker build -t dockyard:mysql -", build_dockerfile(recipe))
  end

  it "should install riak" do
    require "dockyard/recipes/riak"
    recipe = Dockyard::Recipes::Riak.new("1.2.0")
    cmd = build_dockerfile(recipe)
    @ssh.execute("docker build -t dockyard:riak -", cmd)
  end
end
