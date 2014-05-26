module VSphere
  class VCenter
    include VSphere::Conversions
    attr_reader :datacenter, :host_list, :datastores, :summary

    def initialize(vim)
      @vim        = vim
      @datacenter = @vim.serviceInstance.find_datacenter
      @host_list  = Host(datacenter.hostFolder.children)
      @datastores = Datastore(datacenter.datastore)
      @summary    = Summary(host_list + datastores)
    end

  end
end
