module VSphere
  class DatastoreSummaryFactory < SummaryFactory

  private

    class << self

      def make_struct
        if subject.is_a? RbVmomi::VIM::Datastore
          VSphere::Summary.new({capacity: subject.summary.capacity, free_space: subject.summary.freeSpace})
        else
          super
        end
      end

      def object_set
        [{
          :obj => subject,
          :selectSet => [
            RbVmomi::VIM.TraversalSpec(
            :name => 'datastore',
            :type => subject.class.name.split('::').last,
            :path => 'datastore',
            :skip => false
            )
          ]
        }]
      end

      def properties_set
        [{
          :pathSet => vm_fields,
          :type => 'Datastore'
        }]
      end

      def stats
        { capacity: 0, free_space: 0 }
      end

      def vm_fields
        ['summary.freeSpace', 'summary.capacity']
      end

      def rules
        {
          capacity:   -> x { x['summary.capacity'] || 0 },
          free_space: -> x { x['summary.freeSpace'] || 0 }
        }
      end

    end
  end
end
