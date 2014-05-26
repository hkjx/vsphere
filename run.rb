require 'rbvmomi'
require_relative 'lib/vsphere.rb'

vim = RbVmomi::VIM.connect(host: "10.75.11.202", user: 'svc-vmcreator', password: 'O5ZkSFQ8b8gP', insecure: true)
c = VSphere::VCenter.new(vim)
p c.summary.memory_stats
p c.summary.cpu_frequency_stats
p c.summary.storage_stats
p "_"*100
p c.host_list[1].name
p c.host_list[1].summary.memory_stats
p c.host_list[1].summary.cpu_frequency_stats
p c.host_list[1].summary.storage_stats
p c.host_list[1].datastores.size

# p c.host_list.map{|x| x.summary.total_memory}


  # attr_reader :connection_options

  # def initialize(vim)
  #   @vim = vim

  #   # self.connection_options = options
  #   # @vim = RbVmomi::VIM.connect(connection_options)
  # end


  # def connection_options=(hash)
  #   raise ArgumentError, "options must have hash format" unless hash.is_a? Hash
  #   required_options.each { |key| hash.fetch(key) { raise ArgumentError, "options must have #{key}"} }

  #   @connection_options = hash
  # end

  # def required_options
  #   [:host, :user, :password, :insecure]
  # end
