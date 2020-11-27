control "M-4.11" do
  title "4.11 Restrict access to Tomcat logging.properties (Scored)"
  desc  "logging.properties is a Tomcat files which specifies the logging
configuration. It is recommended that access to this file has the proper
permissions to properly protect from unauthorized changes. Restricting access
to this file will prevent local users from maliciously or inadvertently
altering Tomcat’s security policy. "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "4.11"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  desc 'check', "Perform the following to determine if the ownership and
permissions on
$CATALINA_HOME/conf/logging.properties care securely configured. Change to the
location of the $CATALINA_HOME/conf and execute the following:
# cd $CATALINA_HOME/conf/
# find logging.properties -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user
tomcat_admin -o ! -group tomcat \\) -ls
Note: If the ownership and permission are set correctly, no output should be
displayed when executing the above command.
"
  desc 'fix', "Perform the following to restrict access to logging.properties:
Set the ownership of the $CATALINA_HOME/conf/logging.properties to
tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
Remove write permissions for the group.
# chown tomcat_admin:tomcat $CATALINA_HOME/conf/logging.properties
# chmod g-w,o-rwx $CATALINA_HOME/conf/logging.properties

"
  desc 'default value', "The default permissions are 600."

  describe file("#{input('tomcat_home')}/conf/logging.properties") do
    its('owner') { should cmp "#{input('tomcat_owner')}" }
    its('group') { should cmp "#{input('tomcat_group')}" }
    its('mode') { should cmp '0750' }
  end
end
