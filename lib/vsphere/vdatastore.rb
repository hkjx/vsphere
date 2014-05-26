module VSphere
  class VDatastore
    include VSphere::Displayable

    attr_reader :summary

    def initialize(instance)
      @datastore = instance
      @summary = VSphere::Conversions::Summary @datastore
    end

    def name
      @datastore.name
    end

  end
end
