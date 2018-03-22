control "M-10.12" do
  title "10.12 Force SSL for all applications (Scored)"
  desc  "Use the transport-guarantee attribute to ensure SSL protection when
accessing all applications. This can be overridden to be disabled on a per
application basis in the application configuration. By default, when accessing
applications SSL will be enforced to protect information sent over the network.
By using the transport-guarantee attribute within web.xml, SSL is enforced.
NOTE: This requires SSL to be configured. "
  impact 0.5
  tag "ref": "1. http://www.owasp.org/index.php/Securing_tomcat "
  tag "severity": "medium"
  tag "cis_id": "10.12"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  tag "audit text": "Ensure $CATALINA_HOME/conf/web.xml has theattribute set to
CONFIDENTIAL.
# grep transport-guarantee $CATALINA_HOME/conf/web.xml
"
  tag "fix": "In $CATALINA_HOME/conf/web.xml, set the following:
<user-data-constraint>
<transport-guarantee>CONFIDENTIAL</transport-guarantee>
<user-data-constraint>
"
  tag "Default Value": "By default, this configuration is not present.\n"
end
