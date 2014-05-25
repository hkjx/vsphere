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
    def percent_space; used_space/d(capacity)      end


    #properties' functions
    def total_cpu_frequency;      summary.totalCpu            end
    def used_cpu_frequency;       summary.effectiveCpu        end
    def percent_cpu_frequency;    used_cpu_frequency/d(total_cpu_frequency) end

    def cpu_cores_number ;        summary.numCpuCores         end
    def cpu_threads_number;       summary.numCpuThreads       end

    def total_memory;             summary.totalMemory         end
    def used_memory;              summary.effectiveMemory     end
    def percent_memory;           used_memory/d(total_memory)  end

    def total_hosts_number;       summary.numHosts            end
    def used_hosts_number;        summary.numEffectiveHosts   end
    def percent_hosts_number;     used_hosts_number/d(hosts_number)  end
    
    def target_balance;           summary.targetBalance       end  
    def current_balance ;         summary.currentBalance      end
    def percent_balance;          current_balance/d(target_balance)  end


    def overall_status ;          summary.overallStatus          end
    def current_failover_level;   summary.currentFailoverLevel   end

    def current_cpu_failover_resources_percent ;      summary.currentCpuFailoverResourcesPercent          end
    def current_memory_failover_resources_percent;    summary.currentMemoryFailoverResourcesPercent       end

    def numVmotions ;   @summary.numCpuCores   end

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
      raise ArgumntError, 'Summery must be hash' unless hash.is_a? Hash
      hash.select!{ |k,v| self.class.available_fields.include? k }
      @summary = OpenStruct.new hash
    end


  end
end