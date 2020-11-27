# frozen_string_literal: true

control 'M-9.3' do
  title '9.3 Disable deploy on startup of applications (Scored)'
  desc  "Tomcat allows auto deployment of applications. It is recommended that
this capability be disabled. This could allow malicious or untested
applications to be deployed and should be disabled. "
  impact 0.5
  tag "ref": "1.
http://tomcat.apache.org/tomcat-8.0-doc/deployerhowto.html#Deployment_on_Tomcat_startup
2.
https://tomcat.apache.org/tomcat-8.0doc/config/host.html#Automatic_Application_Deployment
3. https://tomcat.apache.org/tomcat-8.0-doc/config/host.html  10 Miscellaneous
Configuration Settings Store web content on a separate partition from Tomcat
system files."
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
