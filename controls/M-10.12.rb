input('tomcat_service_name')= input(
  'tomcat_service_name',
  description: 'Name of Tomcat service',
  value: 'tomcat'
)

TOMCAT_CONF_SERVER= input(
  'tomcat_conf_server',
  description: 'Path to tomcat server.xml',
  value: '/usr/share/tomcat/conf/server.xml'
)

input('tomcat_app_dir')= input(
  'tomcat_app_dir',
  description: 'location of tomcat app directory',
  value: '/var/lib/tomcat'
)

TOMCAT_CONF_WEB= input(
  'tomcat_conf_web',
  description: 'location of tomcat web.xml',
  value: '/usr/share/tomcat/conf/web.xml'
)



control "M-10.12" do
  title "10.12 Force SSL for all applications (Scored)"
  desc  "Use the transport-guarantee attribute to ensure SSL protection when
accessing all applications. This can be overridden to be disabled on a per
application basis in the application configuration. By default, when accessing
applications SSL will be enforced to protect information sent over the network.
By using the transport-guarantee attribute within web.xml, SSL is enforced.
NOTE: This requires SSL to be configured. "
  impact 0.5
  tag "ref": "1. http://www.owasp.org/index.php/Securing_tomcat"
  tag "severity": "medium"
  tag "cis_id": "10.12"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  desc 'check', "Ensure $CATALINA_HOME/conf/web.xml has the attribute set
to CONFIDENTIAL.
# grep transport-guarantee $CATALINA_HOME/conf/web.xml
"
  desc 'fix', "In $CATALINA_HOME/conf/web.xml, set the following:
<user-data-constraint>
<transport-guarantee>CONFIDENTIAL</transport-guarantee>
<user-data-constraint>
"
  desc 'default value', "By default, this configuration is not present.\n"

  begin
    describe xml(TOMCAT_CONF_WEB) do
      its('web-app/security-constraint/user-data-constraint/transport-guarantee') { should eq ['CONFIDENTIAL'] }
    end
  end
end
