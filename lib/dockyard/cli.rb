require "dockyard/recipes/all"

module Dockyard
  class CLI
    def initialize(args)
      @args = args
      @rest_args = opts.parse(@args)
    end

    def to_dockerfile
      case action
      when "build"
        begin
        clazz = eval("Dockyard::Recipes::#{name.capitalize}")
        recipe = clazz.new(version)
        recipe.from(@from) if @from
        recipe.compile
        recipe.to_dockerfile + "\n"
        rescue NameError
          puts "ERROR: recipe #{name.inspect} unknown. Use one of #{Dockyard::Recipes::Base.all_names.to_a.sort.join(", ")}"
          abort opts.to_s
        end
      else
        puts %(ERROR: command #{action.inspect} unknown. Currently only "build" is supported)
        abort opts.to_s
      end
    end

    def action
      @rest_args.at(0)
    end

    def name
      @rest_args.at(1)
    end

    def version
      @rest_args.at(2)
    end

    def opts
      return @opts if @opts
      require "optparse"
      @opts = OptionParser.new
      @opts.banner = "Usage: #{File.basename(__FILE__)} <build> <#{Dockyard::Recipes::Base.all_names.to_a.sort.join("|")}> [version]"
      @opts.on("-f FROM", "from to be used as first line of the Dockerfile") do |value|
        @from = value
      end
      @opts
    end
  end
end
