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

input('tomcat_home')= input(
  'tomcat_home',
  description: 'location of tomcat home directory',
  value: '/usr/share/tomcat'
)



control "M-9.2" do
  title "9.2 Disabling auto deployment of applications (Scored)"
  desc  "Tomcat allows auto deployment of applications while Tomcat is running.
It is recommended that this capability be disabled. This could allow malicious
or untested applications to be deployed and should be disabled. "
  impact 0.5
  tag "ref": "1.
http://tomcat.apache.org/tomcat-8.0-doc/deployerhowto.html#Deploying_on_a_running_Tomcat_server
2. https://tomcat.apache.org/tomcat-8.0-doc/config/host.html"
  tag "severity": "medium"
  tag "cis_id": "9.2"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  desc 'check', "Perform the following to ensure autoDeploy is set to
false.
# grep 'autoDeploy' $CATALINA_HOME/conf/server.xml
"
  desc 'fix', "In the $CATALINA_HOME/conf/server.xml file, change autoDeploy to
false.
autoDeploy='false'
"
  desc 'default value', "autoDeploy is set to true\n"

  begin
    describe xml(TOMCAT_CONF_SERVER) do
      its('Server/Service/Engine/Host/attribute::autoDeploy') { should cmp 'false' }
    end
  end
end
