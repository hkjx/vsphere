module VSphere
  class DatacenterSummaryFactory < SummaryFactory

  private

    class << self

      def make_struct
        p @instance.class
        p @instance.name
        # p instance.host_list.map(&:class)
        # clasters_summary    = Conversions::Summary(instance.host_list).inject(&:+)
        # p clasters_summary
        # datastores_summary  = Conversions::Summary(instance)
        # general_summary     = clasters_summary + datastores_summary

      end

    end
  end
end
