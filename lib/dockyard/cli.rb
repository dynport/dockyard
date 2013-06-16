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
        require "dockyard/recipes/#{name}"
        clazz = eval("Dockyard::Recipes::#{name.capitalize}")
        recipe = clazz.new(@version)
        recipe.from(@from) if @from
        recipe.compile
        recipe.to_dockerfile + "\n"
        rescue LoadError
          puts "ERROR: recipe #{name.inspect} unknown"
          abort opts.to_s
        end
      else
        puts "ERROR: command #{action.inspect} unknown"
        abort opts.to_s
      end
    end

    def name
      @rest_args.at(1)
    end

    def action
      @rest_args.at(0)
    end

    def opts
      return @opts if @opts
      require "optparse"
      @opts = OptionParser.new
      @opts.on("-f FROM") do |value|
        @from = value
      end

      @opts.on("-v VERSION") do |value|
        @version = value
      end
      @opts
    end
  end
end
