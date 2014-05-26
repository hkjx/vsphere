require 'ostruct'

module VSphere
  class Summary
    include VSphere::Displayable

    def initialize(subject)
      self.summary = subject.summary.props
    end

    def capacity;      summary.capacity            end
    def free_space;    summary.freeSpace           end
    def used_space;    capacity - free_space       end

    #properties' functions
    def total_cpu_frequency;      summary.totalCpu            end
    def used_cpu_frequency;       summary.effectiveCpu        end

    def cpu_cores_number ;        summary.numCpuCores         end
    def cpu_threads_number;       summary.numCpuThreads       end

    def total_memory;             summary.totalMemory         end
    def used_memory;              summary.effectiveMemory     end

    def total_hosts_number;       summary.numHosts            end
    def used_hosts_number;        summary.numEffectiveHosts   end

    def target_balance;           summary.targetBalance       end
    def current_balance ;         summary.currentBalance      end


    def overall_status ;          summary.overallStatus          end
    def current_failover_level;   summary.currentFailoverLevel   end

    def current_cpu_failover_resources_percent ;      summary.currentCpuFailoverResourcesPercent          end
    def current_memory_failover_resources_percent;    summary.currentMemoryFailoverResourcesPercent       end

    def numVmotions ;   @summary.numVmotions   end

    def self.available_fields
      [:totalCpu, :totalMemory, :numCpuCores, :numCpuThreads, :effectiveCpu, :effectiveMemory, :numHosts, :numEffectiveHosts, :overallStatus, :currentFailoverLevel, :numVmotions, :targetBalance, :currentBalance, :name, :url, :capacity, :freeSpace, :accessible, :multipleHostAccess, :type, :maintenanceMode]
    end

  private

    def summary
      @summary
    end

    def d(number)
      number = number.to_f
      number.zero? ? 1 : number
    end

    def summary=(hash)
      raise ArgumentError, 'Summery must be hash' unless hash.is_a? Hash
      hash.select!{ |k,v| self.class.available_fields.include? k }
      @summary = OpenStruct.new hash
    end

    def extract_summary(subject)
      filterSpec = RbVmomi::VIM.PropertyFilterSpec(
      :objectSet => [{
        :obj => subject,
        :selectSet => [
          RbVmomi::VIM.TraversalSpec(
            :name => 'tsHosts',
            :type => subject.class_name,
            :path => 'host',
            :skip => false
          )
        ]
      }],
      :propSet => [{
        :pathSet => %w(parent name overallStatus summary.hardware.cpuMhz
                    summary.hardware.numCpuCores summary.hardware.memorySize
                    summary.quickStats.overallCpuUsage
                    summary.quickStats.overallMemoryUsage),
              :type => 'HostSystem'
            }]
          )
      # http://grepcode.com/file/repo1.maven.org/maven2/net.java.dev.vcc.thirdparty/vi-api/4.0.0-4/com/vmware/vim/HostHardwareSummary.java#HostHardwareSummary
      #http://grepcode.com/file/repo1.maven.org/maven2/net.java.dev.vcc.thirdparty/vi-api/4.0.0-4/com/vmware/vim/HostListSummaryQuickStats.java#HostListSummaryQuickStats.0overallMemoryUsage

      vim.propertyCollector.RetrieveProperties(specSet: [filterSpec])

      stats = {
        :totalCPU => 0,
        :totalMem => 0,
        :usedCPU => 0,
        :usedMem => 0,
      }

      result.each do |x|
        next if x['overallStatus'] == 'red'
        stats[:totalCPU] += x['summary.hardware.cpuMhz'] * x['summary.hardware.numCpuCores']
        stats[:totalMem] += x['summary.hardware.memorySize'] / (1024*1024)
        stats[:usedCPU] += x['summary.quickStats.overallCpuUsage'] || 0
        stats[:usedMem] += x['summary.quickStats.overallMemoryUsage'] || 0
      end

      stats
    end
  end
end
