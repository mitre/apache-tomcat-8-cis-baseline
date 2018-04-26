require 'happymapper'
require_relative 'tomcat'

class Role
  include HappyMapper
  tag 'role'

  attribute :name, String, tag: 'rolename'
end

class User
  include HappyMapper
  tag 'user'

  attribute :username, String, tag: 'username'
  attribute :password, String, tag: 'password'
  attribute :raw_roles, String, tag: 'roles'
  # attribute :roles, Array, tag: 'roles', on_load: lambda {|text| text.split(',')}, on_save: lambda {|array| array.join(',')}
  # attribute :roles, Array, tag: 'roles', deliminter: ','

  def roles
    raw_roles.split(',')
  end
end

class TomcatUsers
  include HappyMapper
  tag 'tomcat-users'

  has_many :roles, Role, tag: 'role'
  has_many :users, User, tag: 'user'
end

class TomcatUsersConf < Inspec.resource(1)
  name 'tomcat_users_conf_broke'
  include HappyMapper

  attr_reader :params, :parse_conf, :fetch_users, :get_roles

  def initialize(conf_path = nil)
    @conf_file = conf_path # || File.expand_path('tomcat-users.xml', tomcat.conf_dir)
    @content = File.read(@conf_file)
    @params = {}
    parse_conf
  end

  def parse_conf
    @params = TomcatUsers.parse(@conf_file)
  end

  def fetch_users
    @params.users.map { |x| { username: x.username, password: x.password, roles: x.roles } }
  end

  def get_roles
    @params.roles.map { |user| user.join(',') }
  end

  filter = FilterTable.create
  filter.add_accessor(:where)
        .add_accessor(:entries)
        .add(:users,           field: 'username')
        .add(:passwords,       field: 'password')
        .add(:roles,           field: 'roles')
  filter.connect(self, :fetch_users)
end
