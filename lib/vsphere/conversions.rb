module VSphere
  module Conversions
    module_function

    def Datastore(arg)
      case arg
      when VSphere::VDatastore                    then arg
      when RbVmomi::VIM::Datastore                then VSphere::VDatastore.new(arg)
      when Array                                  then arg.map{ |x| send __method__, x }
      else raise TypeError, "can't convert #{arg} into VDatastore"
      end
    end

    def Host(arg)
      case arg
      when VSphere::VCluster                      then arg
      when RbVmomi::VIM::ClusterComputeResource   then VSphere::VCluster.new(arg)
      when Array                                  then arg.map{ |x| send __method__, x }
      else raise TypeError, "can't convert #{arg} into VCluster"
      end
    end

    def Summary(arg)
      case arg
      when nil                                    then arg VSphere::SummaryFactory.create(nil)
      when VSphere::Summary                       then arg
      when VSphere::VCluster                      then arg.summary
      when VSphere::VDatastore                    then arg.summary
      when VSphere::VCenter                       then arg.summary

      when RbVmomi::VIM::ClusterComputeResource   then VSphere::ClusterSummaryFactory.create(arg)
      when RbVmomi::VIM::Datastore                then VSphere::DatastoreSummaryFactory.create(arg)
      when Array
        arg.map{ |x| send __method__, x }.inject(&:+) || VSphere::SummaryFactory.create(nil)
      else raise TypeError, "can't convert #{arg} into Summary"
      end
    end

  end
end
