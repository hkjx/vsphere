module VSphere
  class Summary

    def initialize(hash)
      generate_methods hash
    end

  private

    def generate_methods(hash)
      singleton_class.class_exec do
        attr_reader *hash.keys
      end

      instance_eval do
        hash.each do |key, value|
          key = "@#{key}".to_sym
          instance_variable_set(key, value)
        end
      end
    end

  end
end
