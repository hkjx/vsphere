module VSphere
  module Cloudable
    attr_reader :instance, :summary

    def self.included(base)
      base.send(:include, Displayable)
      base.send(:include, Conversions)
    end

    def initialize(instance)
      @instance = instance
    end

    def name
      instance.name
    end

  end
end
