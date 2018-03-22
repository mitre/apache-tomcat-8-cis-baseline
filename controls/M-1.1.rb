control "M-1.1" do
  title "1.1 Remove extraneous files and directories (Scored)"
  desc  "The installation may provide example applications, documentation, and
other directories which may not serve a production use. Removing sample
resources is a defense in depth measure that reduces potential exposures
introduced by these resources. "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "1.1"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  tag "audit text": "Perform the following to determine the existence of
extraneous resources:
List all files extraneous files. The following should yield no output:
$ ls -l $CATALINA_HOME/webapps/js-examples \\
$CATALINA_HOME/webapps/servlet-example \\
$CATALINA_HOME/webapps/webdav \\
$CATALINA_HOME/webapps/tomcat-docs \\
$CATALINA_HOME/webapps/balancer \\
$CATALINA_HOME/webapps/ROOT/admin \\
$CATALINA_HOME/webapps/examples \\
$CATALINA_HOME/server/webapps/host-manager \\
$CATALINA_HOME/server/webapps/manager \\
$CATALINA_HOME/conf/Catalina/localhost/host-manager.xml \\
$CATALINA_HOME/conf/Catalina/localhost/manager.xml
"
  tag "fix": "Perform the following to remove extraneous resources:
The following should yield no output:
$ rm -rf $CATALINA_HOME/webapps/js-examples \\
$CATALINA_HOME/webapps/servlet-example \\
$CATALINA_HOME/webapps/webdav \\
$CATALINA_HOME/webapps/tomcat-docs \\
$CATALINA_HOME/webapps/balancer \\
$CATALINA_HOME/webapps/ROOT/admin \\$CATALINA_HOME/webapps/examples
If the Manager application is not utilized, also remove the following
resources:
$ rm –rf $CATALINA_HOME/server/webapps/host-manager \\
$CATALINA_HOME/server/webapps/manager \\
$CATALINA_HOME/conf/Catalina/localhost/host-manager.xml \\
$CATALINA_HOME/conf/Catalina/localhost/manager.xml
"
  tag "Default Value": "Depending on your install method, default extraneous
resources will vary.\n\n"
end
