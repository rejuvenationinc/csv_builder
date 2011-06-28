# encoding: utf-8

module CsvBuilder
  class CsvProxy < FilterProxy

    def initialize(data, options = {})
      super(data, options).tap do

        init(CSV.new(data, @options), data) do

          @ivar_names = base.instance_variables.select do |ivar|
            CSV::DEFAULT_OPTIONS.keys.map { |key| "@#{key}" }.include?(ivar.to_s)
          end
        end

      end
    end

    def [](key)
      if @ivar_names.include?(ivar_key = "@#{key}".intern)
        base.instance_variable_get(ivar_key)
      end
    end

    def []=(key, value)
      if @ivar_names.include?(ivar_key = "@#{key}".intern)
        base.instance_variable_set(ivar_key, value)
      end
    end

    def settings
      @ivar_names.inject({}) do |hash,key|
        hash.tap do
          hash[key.to_s[1..-1].intern] = base.instance_variable_get(key)
        end
      end
    end

  end
end