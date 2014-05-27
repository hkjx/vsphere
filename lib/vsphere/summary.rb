require 'ostruct'

module VSphere
  class SummaryFactory
    include VSphere::Displayable
    singleton_class.instance_exec{ attr_accessor :subject, :instance }

    def self.create(subject)
      self.instance = subject
      self.subject = subject.instance_variable_get(:@instance)
      make_struct.tap { |x| x.instance_exec{ extend VSphere::Displayable } }
    end

  private

    class << self

      def make_struct
        OpenStruct.new as_hash(extract_summary)
      end

      def extract_summary
        connection = subject.instance_variable_get(:@connection)
        connection.propertyCollector.RetrieveProperties(specSet: [ filter_spec(object_set, properties_set) ])
      end

      def filter_spec(object_set, properties_set)
        RbVmomi::VIM.PropertyFilterSpec(:objectSet => object_set, :propSet =>   properties_set)
      end

      def as_hash(result)
        result_hash = stats

        result.each do |x|
          rules.each{ |field, rule| result_hash[field] += rule.call(x) }
        end

        result_hash
      end

      def object_set
        raise NotImplementError
      end

      def properties_set
        raise NotImplementError
      end

      def stats
        raise NotImplementError
      end

      def vm_fields
        raise NotImplementError
      end

      def rules
        raise NotImplementError
      end

    end

  end
end
