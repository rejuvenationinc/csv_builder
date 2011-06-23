# encoding: utf-8

module CsvBuilder
  class Proxy

    # We undefine most methods to get them sent through to the target.
    instance_methods.each do |method|
      undef_method(method) unless
        method =~ /(^__|^send$|^object_id$|^extend$|^tap$)/
    end

    attr_accessor :base, :target, :options

    def init(base, target, options = {}, &block)
      @base, @target, @options = base, target, options
      block.call if block
    end

    protected

    def method_missing(name, *args, &block)
      base.send(name, *args, &block)
    end

  end
end