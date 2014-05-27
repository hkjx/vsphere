require 'ostruct'

module VSphere
  class DatacenterSummaryFactory < SummaryFactory

  private

    class << self

      def make_struct
        host_lists = instance.host_list

        array = host_lists.inject([]) { |array, host| array << HostSummaryFactory.create(host).marshal_dump }

        result_hash = HostSummaryFactory.send(:stats)

        array.each do |x|
          result_hash.keys.each do |key|
            result_hash[key] += x[key]
          end
        end

        OpenStruct.new result_hash
      end

    end
  end
end
