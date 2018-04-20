control "M-4.9" do
  title "4.9 Restrict access to Tomcat catalina.properties (Scored)"
  desc  "catalina.properties is a Java properties files that contains settings
for Tomcat including class loader information, security package lists, and
performance properties. It is recommended that access to this file has the
proper permissions to properly protect from unauthorized changes. Restricting
access to this file will prevent local users from maliciously or inadvertently
altering Tomcat’s security policy. "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "4.9"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  tag "audit text": "Perform the following to determine if the ownership and
permissions on
$CATALINA_HOME/conf/catalina.properties care securely configured. Change to the
location of the $CATALINA_HOME/ and execute the following:
# cd $CATALINA_HOME/conf/
# find catalina.properties -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user

tomcat_admin -o ! -group tomcat \\) -ls
Note: If the ownership and permission are set correctly, no output should be
displayed when executing the above command.
"
  tag "fix": "Perform the following to restrict access to catalina.properties:
Set the ownership of the $CATALINA_HOME/conf/catalina.properties to
tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
Remove write permissions for the group.
# chown tomcat_admin:tomcat $CATALINA_HOME/conf/catalina.properties
# chmod g-w,o-rwx $CATALINA_HOME/conf/catalina.properties

"
  tag "Default Value": "The default permissions of the top-level directories is
600."
end
