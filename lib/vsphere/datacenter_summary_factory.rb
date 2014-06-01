module VSphere
  class DatacenterSummaryFactory < SummaryFactory
    
  private

    class << self

      def make_struct
        clasters_summary    = Conversions::Summary(instance.host_list).inject(&:+)
        #datastores_summary  = Conversions::Summary(instance)
        general_summary     = clasters_summary# + datastores_summary
      end

    end
  end
end

#<VSphere::Summary:0x913366c @total_cpu=2760736, @total_memory=18346476, @used_cpu=173167, @used_memory=9383011, @hash={:total_cpu=>2760736, :total_memory=>18346476, :used_cpu=>173167, :used_memory=>9383011, :cpu_cores_number=>864}, @cpu_cores_number=864>
