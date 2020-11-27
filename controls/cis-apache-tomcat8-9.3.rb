# frozen_string_literal: true

control 'cis-apache-tomcat8-9.3' do
  title '9.3 Disable deploy on startup of applications (Scored)'
  desc  "Tomcat allows auto deployment of applications. It is recommended that
this capability be disabled. This could allow malicious or untested
applications to be deployed and should be disabled. "
  impact 0.5
  ref 'http://tomcat.apache.org/tomcat-8.0-doc/deployerhowto.html#Deployment_on_Tomcat_startup'
  ref 'https://tomcat.apache.org/tomcat-8.0doc/config/host.html#Automatic_Application_Deployment'
  ref 'https://tomcat.apache.org/tomcat-8.0-doc/config/host.html'
  tag "severity": 'medium'
  tag "cis_id": '9.3'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 2
  desc 'check', "Perform the following to ensure deployOnStartup is set to
false.
# grep 'deployOnStartup' $CATALINA_HOME/conf/server.xml
"
  desc 'fix', "In the $CATALINA_HOME/conf/server.xml file, change
deployOnStartup to false.
deployOnStartup='false'
"
  desc 'default value', "deployOnStartup is set to true\n"

  describe xml(input('tomcat_conf_server')) do
    its('Server/Service/Engine/Host/attribute::deployOnStartup') { should cmp 'false' }
  end
end
