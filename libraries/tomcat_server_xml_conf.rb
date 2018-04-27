require 'happymapper'


class Listener
  include HappyMapper
  tag 'Listener'

  attribute :classname, String, tag: 'className'
end

class Resource
  include HappyMapper
  tag 'Resource'

  attribute :name, String, tag: 'name'
  attribute :auth, String, tag: 'auth'
  attribute :type, String, tag: 'type'
  attribute :desc, String, tag: 'description'
  attribute :factory, String, tag: 'factory'
  attribute :path, String, tag: 'pathname'
end

class GlobalNamingResources
  include HappyMapper
  tag 'GlobalNamingResource'

  has_many :resources, Resource, tag: 'resource'
end

class Connector
  include HappyMapper
  tag 'Connector'

  attribute :port, String, tag: 'port'
  attribute :protocol, String, tag: 'protocol'
  attribute :timeout, String, tag: 'connectionTimeout'
  attribute :redirectport, String, tag: 'redirectPort'
  attribute :sslprotocol, String, tag: 'sslProtocol'
  attribute :scheme, String, tag: 'scheme'
  attribute :sslenable, String, tag: 'SSLEnabled'
  attribute :clientauth, String, tag: 'clientAuth'
end


class Service
  include HappyMapper
  tag 'Service'

  attribute :name, String, tag: 'name'
  has_many :connectors, Connector, tag: 'Connector'
end


# class Engine
#
# class Realm
# end

class Server
  include HappyMapper
  tag 'Server'

  attribute :port, String, tag: 'port'
  attribute :shutdown, String, tag: 'shutdown'
  has_many :listeners, Listener, tag: 'Listener'
  has_one :globalnameres, GlobalNamingResources, tag: 'GlobalNamingResource'
  has_one :service, Service, tag: 'Service'
end

x = Server.parse(File.read('/Users/cchaffee/Repos/cis_apache_tomcat_benchmark_8/server.xml'))

require 'pry'

binding.pry
