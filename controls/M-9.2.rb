control "M-9.2" do
  title "9.2 Disabling auto deployment of applications (Scored)"
  desc  "Tomcat allows auto deployment of applications while Tomcat is running.
It is recommended that this capability be disabled. This could allow malicious
or untested applications to be deployed and should be disabled. "
  impact 0.5
  tag "ref": "1.
http://tomcat.apache.org/tomcat-7.0-doc/deployerhowto.html#Deploying_on_a_running_Tomcat_server
2. https://tomcat.apache.org/tomcat-7.0-doc/config/host.html  "
  tag "severity": "medium"
  tag "cis_id": "9.2"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  tag "audit text": "Perform the following to ensure autoDeploy is set to
false.
# grep 'autoDeploy' $CATALINA_HOME/conf/server.xml
"
  tag "fix": "In the $CATALINA_HOME/conf/server.xml file, change autoDeploy to
false.
autoDeploy='false'
"
  tag "Default Value": "autoDeploy is set to true\n"
end
