control "M-4.6" do
  title "4.6 Restrict access to Tomcat binaries directory (Scored)"
  desc  "The Tomcat $CATALINA_HOME/bin/ directory contains executes that are
part of the Tomcat run-time. It is recommended that the ownership of this
directory be tomcat_admin:tomcat. It is also recommended that the permission on
this directory prevent read, write, and execute for the world (o-rwx) and
prevent write access to the group (g-w). Restricting access to these
directories will prevent local users from maliciously or inadvertently
affecting the integrity of Tomcat processes. "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "4.6"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  tag "audit text": "Perform the following to determine if the ownership and
permissions on
$CATALINA_HOME/bin are securely configured. Change to the location of the
$CATALINA_HOME/bin and execute the following:
# cd $CATALINA_HOME
# find bin -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin -o
! -group
tomcat \\) -ls
Note: If the ownership and permission are set correctly, no output should be
displayed
when executing the above command.
"
  tag "fix": "Perform the following to restrict access to Tomcat log files: Set
the ownership of the $CATALINA_HOME/logs to tomcat_admin:tomcat. Remove read,
write, and execute permissions for the world Remove write permissions for the
group.
# chown tomcat_admin:tomcat $CATALINA_HOME/bin
# chmod g-w,o-rwx $CATALINA_HOME/bin
"
  tag "Default Value": "The default permissions of the top-level directories is
770.\n\n"
end
