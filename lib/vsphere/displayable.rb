module VSphere
  module Displayable

    #stats format functions
    def memory_stats
      { total: total_memory, used: used_memory, free: total_memory - used_memory }
    end

    def cpu_cores_stats
      { total: cpu_cores_number, used: nil, free: nil }
    end

    def cpu_frequency_stats
      { total: total_cpu_frequency, used: used_cpu_frequency, free: total_cpu_frequency - used_cpu_frequency }
    end

    def storage_stats
      { total: capacity, used: capacity - free_space, free: free_space }
    end

  end
end
