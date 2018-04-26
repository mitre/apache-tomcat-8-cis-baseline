require 'happymapper'
require 'utils/file_reader'

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
  name 'tomcat_users_conf'
  include HappyMapper
  include FileReader

  attr_reader :params

  def initialize(path = nil)
    @conf_path = path || '/usr/share/tomcat/tomcat-users.xml'
    @content = read_file_content(@conf_path)
    @params = []
    parse_conf
  end

  filter = FilterTable.create
  filter.add_accessor(:where)
        .add_accessor(:entries)
        .add(:usernames,           field: :username)
        .add(:passwords,           field: :password)
        .add(:roles,               field: :roles)
        .add(:rolenames,           field: :role_name)
        .add(:exists?) { |x| x.entries.any? }
  filter.connect(self, :params)

  def parse_conf
    @tomcat_users = TomcatUsers.parse(@content)
    fetch_users
    fetch_roles
  end

  def fetch_users
    @tomcat_users.users.each { |user| @params << { username: user.username, password: user.password, roles: user.roles } }
  end

  def fetch_roles
    @tomcat_users.roles.each { |role| @params << { role_name: role.name } }
  end
end