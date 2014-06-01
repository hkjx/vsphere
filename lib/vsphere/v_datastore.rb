module VSphere
  class VDatastore
    include VSphere::Cloudable

    def initialize(instance)
      super(instance)
      @summary = Summary instance
    end

  end
end
