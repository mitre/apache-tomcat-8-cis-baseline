# frozen_string_literal: true

control 'M-4.10' do
  title '4.10 Restrict access to Tomcat context.xml (Scored)'
  desc  "The context.xml file is loaded by all web applications and sets
certain configuration options. It is recommended that access to this file has
the proper permissions to properly protect from unauthorized changes.
Restricting access to this file will prevent local users from maliciously or
inadvertently altering Tomcat’s security policy. "
  impact 0.5
  tag "severity": 'medium'
  tag "cis_id": '4.10'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 1
  desc 'check', "Perform the following to determine if the ownership and
permissions on
$CATALINA_HOME/conf/context.xml care securely configured. Change to the
location of the $CATALINA_HOME/conf and execute the following:
# cd $CATALINA_HOME/conf
# find context.xml -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user
tomcat_admin -o ! -group tomcat \\) -ls
Note: If the ownership and permission are set correctly, no output should be
displayed when executing the above command.
"
  desc 'fix', "Perform the following to restrict access to context.xml: Set the
ownership of the $CATALINA_HOME/conf/context.xml to
tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
Remove write permissions for the group.
# chown tomcat_admin:tomcat $CATALINA_HOME/conf/context.xml
# chmod g-w,o-rwx $CATALINA_HOME/conf/context.xml

"
  desc 'default value', 'The default permissions of context.xml are 600.'

  describe file("#{input('tomcat_home')}/conf/context.xml") do
    its('owner') { should cmp input('tomcat_owner').to_s }
    its('group') { should cmp input('tomcat_group').to_s }
    its('mode') { should cmp '0750' }
  end
end
