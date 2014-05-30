module VSphere
  class Summary

    def initialize(hash)
      generate_methods hash
      @hash = hash
    end

    def to_hash
      @hash
    end

    def +(arg)
      self.class.new @hash.merge(arg.to_hash) {|_,v1,v2| v1 + v2}
    end

    def add_property!(hash)
      @hash.merge!(hash)
      generate_methods(hash)
    end

  private

    def generate_methods(hash)
      singleton_class.class_exec do
        attr_reader *(hash.keys)
      end

      instance_eval do
        hash.each do |key, value|
          key = "@#{key}".to_sym
          instance_variable_set(key, value)
        end
      end

      self
    end

  end
end
