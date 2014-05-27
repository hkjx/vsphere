module VSphere
  class VHost
    include VSphere::Displayable

    attr_reader :summary, :datastores

    def initialize(instance)
      @instance = instance
      @datastores = VSphere::Conversions::Datastore(@instance.datastore)
      # @summary = VSphere::Conversions::Summary [@host] + @datastores
    end

    def name
      @host.name
    end

  end
end
