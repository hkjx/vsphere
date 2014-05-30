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
      when VSphere::Summary                       then arg
      when VSphere::VCluster                      then VSphere::ClusterSummaryFactory.create(arg)
      when VSphere::VDatastore                    then VSphere::DatastoreSummaryFactory.create(arg)
      when VSphere::VCenter                       then VSphere::DatacenterSummaryFactory.create(arg)
      when Array                                  then arg.map{ |x| send __method__, x }
      else raise TypeError, "can't convert #{arg} into Summary"
      end
    end

  end
end
