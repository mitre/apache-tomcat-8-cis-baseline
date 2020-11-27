control "M-4.14" do
  title "4.14 Restrict access to Tomcat web.xml (Scored)"
  desc  "web.xml is a Tomcat configuration file that stores application
configuration settings. It is recommended that access to this file has the
proper permissions to properly protect from unauthorized changes. Restricting
access to this file will prevent local users from maliciously or inadvertently
altering Tomcat’s security policy. "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "4.14"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  desc 'check', "Perform the following to determine if the ownership and
permissions on
$CATALINA_HOME/conf/web.xml care securely configured. Change to the location of
the $CATALINA_HOME/conf and execute the following:
# cd $CATALINA_HOME/conf/
# find web.xml -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin

-o ! -group tomcat \\) -ls
Note: If the ownership and permission are set correctly, no output should be
displayed when executing the above command.
"
  desc 'fix', "Perform the following to restrict access to web.xml: Set the
ownership of the $CATALINA_HOME/conf/web.xml to tomcat_admin:tomcat. Remove
read, write, and execute permissions for the world. Remove write permissions
for the group.
# chown tomcat_admin:tomcat $CATALINA_HOME/conf/web.xml
# chmod g-w,o-rwx $CATALINA_HOME/conf/web.xml
"
  desc 'default value', "The default permissions of web.xml is 400."

  describe file("#{input('tomcat_home')}/conf/web.xml") do
    its('owner') { should cmp "#{input('tomcat_owner')}" }
    its('group') { should cmp "#{input('tomcat_group')}" }
    its('mode') { should cmp '0750' }
  end
end
