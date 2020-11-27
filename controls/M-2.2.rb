input('tomcat_home')= input(
  'tomcat_home',
  description: 'location of tomcat home directory',
  value: '/usr/share/tomcat'
)

input('tomcat_server_number')= input(
  'tomcat_server_number',
  description: 'server.number value',
  value: 'server.number=8.5.31.0'
)

input('tomcat_service_name')= input(
  'tomcat_service_name',
  description: 'Name of Tomcat service',
  value: 'tomcat'
)



control "M-2.2" do
  title "2.2 Alter the Advertised server.number String (Scored)"
  desc  "The server.number attribute represents the specific version of Tomcat
that is executing. This value is presented to Tomcat clients when connect.
Advertising a valid server version may provide attackers with information
useful for locating vulnerabilities that affect the server platform. Altering
the server version string may make it harder for attackers to determine which
vulnerabilities affect the server platform. "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "2.2"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  desc 'check', "Perform the following to determine if the server.number
value has been changed: Extract the ServerInfo.properties file and examine the
server.number attribute.
$ cd $CATALINA_HOME/lib
$ jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties
$ grep server.number org/apache/catalina/util/ServerInfo.properties
"
  desc 'fix', "Perform the following to alter the server version string that
gets displayed when clients
connect to the server. Extract the ServerInfo.properties file from the
catalina.jar file:
$ cd $CATALINA_HOME/lib
$ jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties Navigate
to the util directory that was created
$ cd org/apache/Catalina/util Open ServerInfo.properties in an editor Update
the server.number attribute
server.number=<someversion> Update the catalina.jar with the modified
ServerInfo.properties file.

$ jar uf catalina.jar org/apache/catalina/util/ServerInfo.properties
"
  desc 'default value', "The default value for the server.number attribute is a
four part version number, such as\n5.5.20.0."

#@TODO Make this an active and passive test 
  describe command("unzip -p #{input('tomcat_home')}/lib/catalina.jar org/apache/catalina/util/ServerInfo.properties | grep server.number") do
    its('stdout.strip') { should cmp "#{input('tomcat_server_number')}" }
  end
end
