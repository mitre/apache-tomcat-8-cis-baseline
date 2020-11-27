# -*- encoding : utf-8 -*-
# frozen_string_literal: true

control 'M-4.5' do
  title '4.5 Restrict access to Tomcat temp directory (Scored)'
  desc  "The Tomcat $CATALINA_HOME/temp/ directory is used by Tomcat to persist
temporary information to disk. It is recommended that the ownership of this
directory be tomcat_admin:tomcat. It is also recommended that the permissions
on this directory prevent read, write, and execute for the world (o-rwx).
Restricting access to these directories will prevent local users from
maliciously or inadvertently affecting the integrity of Tomcat processes. "
  impact 0.5
  tag "severity": 'medium'
  tag "cis_id": '4.5'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 1
  desc 'check', "Perform the following to determine if the ownership and
permissions on
$CATALINA_HOME/temp are securely configured. Change to the location of the
$CATALINA_HOME/temp and execute the following:
# cd $CATALINA_HOME
# find temp -follow -maxdepth 0 \\( -perm /o+rwx -o ! -user tomcat_admin -o !
group tomcat \\) -ls
Note: If the ownership and permission are set correctly, no output should be
displayed when executing the above command.
"
  desc 'fix', "Perform the following to restrict access to Tomcat temp
directory: Set the ownership of the $CATALINA_HOME/temp to tomcat_admin:tomcat.
Remove read, write, and execute permissions for the world
# chown tomcat_admin:tomcat $CATALINA_HOME/temp
# chmod o-rwx $CATALINA_HOME/temp
"
  desc 'default value', "The default permissions of the top-level directories is
770."

  describe directory("#{input('tomcat_home')}/temp") do
    its('owner') { should cmp input('tomcat_owner').to_s }
    its('group') { should cmp input('tomcat_group').to_s }
    its('mode') { should cmp '0770' }
  end
end
