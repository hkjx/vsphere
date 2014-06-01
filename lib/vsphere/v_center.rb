module VSphere
  class VCenter
    include VSphere::Cloudable
    attr_reader :datacenter, :host_list, :datastores

    def initialize(vim)
      @vim        = vim
      @instance   = @vim.serviceInstance.find_datacenter
      @host_list  = Host(datacenter.hostFolder.children)
      @summary    = Summary host_list
    end

    def datacenter
      instance
    end

  end
end
