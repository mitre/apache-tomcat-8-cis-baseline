# -*- encoding : utf-8 -*-
control "M-4.1" do
  title "4.1 Restrict access to $CATALINA_HOME (Scored)"
  desc  "$CATALINA_HOME is the environment variable which holds the path to the
root Tomcat directory. It is important to protect access to this in order to
protect the Tomcat binaries and libraries from unauthorized modification. It is
recommended that the ownership of $CATALINA_HOME be tomcat_admin:tomcat. It is
also recommended that the permission on $CATALINA_HOME prevent read, write, and
execute for the world (o-rwx) and prevent write access to the group (g-w). The
security of processes and data that traverse or depend on Tomcat may become
compromised if the $CATALINA_HOME is not secured. "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "4.1"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  desc 'check', "Perform the following to ensure the permission on the
$CATALINA_HOME directory
prevent unauthorized modification.
$ cd $CATALINA_HOME
$ find . -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin -o !
-group
tomcat \\) -ls
The above command should not emit any output.
"
  desc 'fix', "Perform the following to establish the recommended state: Set the
ownership of the $CATALINA_HOME to tomcat_admin:tomcat. Remove read, write, and
execute permissions for the world Remove write permissions for the group.

# chown tomcat_admin.tomcat $CATALINA_HOME
# chmod g-w,o-rwx $CATALINA_HOME"

  describe directory("#{input('tomcat_home')}") do
    its('owner') { should cmp "#{input('tomcat_owner')}" }
    its('group') { should cmp "#{input('tomcat_group')}" }
    its('mode') { should cmp '0750' }
  end
end
