require_relative './vhost.rb'
require_relative './summary.rb'
require_relative './vdatastore.rb'

module VSphere
  module Conversions
    module_function

    def Datastore(arg)
      case arg
      when VSphere::VDatastore                    then arg
      when RbVmomi::VIM::Datastore                then VDatastore.new(arg)
      when Array                                  then arg.map{ |x| send __method__, x }
      else raise TypeError, "can't convert #{arg} into VDatastore"
      end
    end

    def Host(arg)
      case arg
      when VSphere::VHost                         then arg
      when RbVmomi::VIM::ClusterComputeResource   then VHost.new(arg)
      when Array                                  then arg.map{ |x| send __method__, x }
      else raise TypeError, "can't convert #{arg} into VHost"
      end
    end

    def Summary(arg)
      case arg
      when VSphere::Summary                       then arg
      when VSphere::VHost                         then arg.summary
      when VSphere::VDatastore                    then arg.summary

      when RbVmomi::VIM::ClusterComputeResource   then VSphere::Summary.new(arg)
      when RbVmomi::VIM::Datastore                then VSphere::Summary.new(arg)
      when VSphere::VHost                         then VSphere::Summary.new(arg.instance_variable_get(:@host))
      when Array
        methods = VSphere::Summary.available_fields
        res = OpenStruct.new
        arg.map!{ |x| send(__method__, x).send(:summary) }

        methods.each do |method|
          value = arg.inject(0){ |sum, i| sum + (Integer(i.send(method)) rescue 0) }
          res.send("#{method}=", value)
        end

        res.summary = OpenStruct.new(props: res.marshal_dump)
        VSphere::Summary.new(res)
      else raise TypeError, "can't convert #{arg} into Summary"
      end
    end

  end
end
