control "M-5.1" do
  title "5.1 Use secure Realms (Scored)"
  desc  "A realm is a database of usernames and passwords used to identify
valid users of web applications. Review the Realms configuration to ensure
Tomcat is configured to use JDBCRealm, UserDatabaseRealm, or JAASRealm.
Specifically, Tomcat should not utilize MemoryRealm. According to the Tomcat
documentation, MemoryRealm, JDBCRealm are not designed for production usage and
could result in reduced availability, the UserDatabaseRealm is not intended for
large-scale installations, the JAASRealm is not widely used and therefore the
code is not as mature as the other realms. "
  impact 0.5
  tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/realm-howto.html 2.
https://tomcat.apache.org/tomcat-8.0-doc/security-howto.html"
  tag "severity": "medium"
  tag "cis_id": "5.1"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  desc 'check', "Perform the following to ensure improper realm is not in
use:
#
#
#
#
grep
grep
grep
grep
'Realm
'Realm
'Realm
'Realm
className'
className'
className'
className'
$CATALINA_HOME/conf/server.xml
$CATALINA_HOME/conf/server.xml
$CATALINA_HOME/conf/server.xml
$CATALINA_HOME/conf/server.xml
|
|
|
|
grep
grep
grep
grep
MemoryRealm
JDBCRealm
UserDatabaseRealm
JAASRealm
The above commands should not emit any output.
"
  desc 'fix', "Set the Realm className setting in $CATALINA_HOME/conf/server.xml
to one of the
appropriate realms.
"

  # @TODO update this to use looping expect syntax with a subject block
  describe xml("#{input('tomcat_home')}/conf/server.xml") do
    its('Server/Service/Engine/Realm/@className') { should_not be_in input('tomcat_realms_list') }
    its('Server/Service/Engine/Realm/Realm/@className') { should_not be_in input('tomcat_realms_list') }
    its('Server/Service/Host/Realm/@className') { should_not be_in input('tomcat_realms_list') }
    its('Server/Service/Host/Realm/Realm/@className') { should_not be_in input('tomcat_realms_list') }
    its('Server/Service/Context/Realm/@className') { should_not be_in input('tomcat_realms_list') }
    its('Server/Service/Context/Realm/Realm/@className') { should_not be_in input('tomcat_realms_list') }
  end

  describe xml("#{input('tomcat_home')}/conf/context.xml") do
    its('Context/Realm/@className') { should_not be_in input('tomcat_realms_list') }
    its('Context/Realm/Realm/@className') { should_not be_in input('tomcat_realms_list') }
  end
end
