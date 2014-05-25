class VHost
  include VSphere::Displayable

  attr_reader :summary

  def initialize(instance)
    @host = instance
    @summary = VSphere::Conversions::Summary @host
  end

  def name
    @host.name 
  end

end