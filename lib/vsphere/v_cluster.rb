module VSphere
  class VCluster
    include VSphere::Cloudable

    attr_reader :hosts, :datastores

    def initialize(instance)
      super instance
      @datastores = Datastore(@instance.datastore)
      @summary = Summary self
    end

  end
end
