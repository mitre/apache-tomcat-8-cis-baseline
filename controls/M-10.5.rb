control "M-10.5" do
  title "10.5 Rename the manager application (Scored)"
  desc  "The manager application allows administrators to manage Tomcat
remotely via a web interface. The manager application should be renamed to make
it harder for attackers or automated scripts to locate. Obscurity can be
helpful when used with other security measures. By relocating the manager
applications, an attacker will need to guess its location rather than simply
navigate to the standard location in order to carry out an attack. "
  impact 0.5
  tag "ref": "1. https://www.owasp.org/index.php/Securing_tomcat "
  tag "severity": "medium"
  tag "cis_id": "10.5"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  tag "audit text": "Ensure $CATALINA_HOME/conf/Catalina/localhost/manager.xml,

$CATALINA_HOME/webapps/host-manager/manager.xml,
$CATALINA_HOME/webapps/manager and $CATALINA_HOME/webapps/manager do not
exsist.
"
  tag "fix": "Perform the following to rename the manager application: Rename
the manager application XML file:
# mv $CATALINA_HOME/webapps/host-manager/manager.xml \\
$CATALINA_HOME/webapps/host-manager/new-name.xml Update the docBase attribute
within $CATALINA_HOME/webapps/host-manager/newname.xml to
${catalina.home}/server/webapps/new-name Move $CATALINA_HOME/webapps/manager to
$CATALINA_HOME/webapps/newname
# mv $CATALINA_HOME/webapps/manager $CATALINA_HOME/webapps/new-name
"
  tag "Default Value": "The default name of the manager application is
“manager\" and is located at:\n$CATALINA_HOME/webapps/manager\n"
end
