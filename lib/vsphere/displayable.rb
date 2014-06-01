module VSphere
  module Displayable

    #stats format functions
    def memory_stats
      { total: total_memory, used: used_memory, free: total_memory - used_memory }
    end

    def cpu_cores_stats
      { total: cpu_cores_number, used: nil, free: nil }
    end

    def cpu_stats
      { total: total_cpu, used: used_cpu, free: total_cpu - used_cpu }
    end

    def storage_stats
      { total: capacity, used: capacity - free_space, free: free_space }
    end

  end
end
