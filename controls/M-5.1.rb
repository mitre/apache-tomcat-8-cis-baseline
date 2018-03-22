control "M-5.1" do
  title "5.1 Use secure Realms (Scored)"
  desc  "A realm is a database of usernames and passwords used to identify
valid users of web applications. Review the Realms configuration to ensure
Tomcat is not configured to use JDBCRealm, UserDatabaseRealm or JAASRealm.
Specifically, Tomcat should not utilize MemoryRealm. The MemoryRealm is not
intended for production use as any changes to tomcat-users.xml require a
restart of Tomcat to take effect. The JDBCRealm is not recommended for
production use as it is single threaded for all authentication and
authorization options. Use the DataSourceRealm instead. The UserDatabaseRealm
is not intended for large-scale installations. It is intended for small-scale,
relatively static environments. The JAASRealm is not widely used and therefore
the code is not as mature as the other realms. Additional testing is
recommended before using this realm. "
  impact 0.5
  tag "ref": "1. http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html  "
  tag "severity": "medium"
  tag "cis_id": "5.1"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  tag "audit text": "Perform the following to ensure the MemoryRealm is not in
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
The above command should not emit any output.
"
  tag "fix": "Set the Realm className setting in $CATALINA_HOME/conf/server.xml
to one of the
appropriate realms.
"
end
