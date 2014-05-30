module VSphere
  class ClusterSummaryFactory < SummaryFactory

    def self.make_struct
      summary = super
      summary.add_property!({:cpu_cores_number => subject.summary.numCpuCores })
      summary
    end

  private
    class << self
      def object_set
        [{
          :obj => @subject,
          :selectSet => [
            RbVmomi::VIM.TraversalSpec(
            :name => 'host',
            :type => @subject.class.name.split('::').last,
            :path => 'host',
            :skip => false
            )
          ]
        }]
      end

      def properties_set
        [{
          :pathSet => vm_fields,
          :type => 'HostSystem'
        }]
      end

      def stats
        { :total_cpu => 0, :total_memory => 0, :used_cpu => 0, :used_memory => 0 }
      end

      def vm_fields
        ["parent", "name", "overallStatus", "summary.hardware.cpuMhz", "summary.hardware.numCpuCores", "summary.hardware.memorySize", "summary.quickStats.overallCpuUsage", "summary.quickStats.overallMemoryUsage"]
      end

      def rules
        {
          total_cpu:      -> x { x['summary.hardware.cpuMhz'] * x['summary.hardware.numCpuCores'] },
          total_memory:   -> x { x['summary.hardware.memorySize'] / (1024*1024) },
          used_cpu:       -> x { x['summary.quickStats.overallCpuUsage'] || 0 },
          used_memory:    -> x { x['summary.quickStats.overallMemoryUsage'] || 0 }
        }
      end
    end

  end
end
