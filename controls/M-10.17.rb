control "M-10.17" do
  title "10.17 Do not resolve hosts on logging valves (Scored)"
  desc  "Setting enableLookups to true on Connector requires a DNS look-up
before logging the information. This adds additional resources when logging.
Allowing enableLookups adds additional overhead that is rarely needed. "
  impact 0.5
  tag "ref": "1. https://tomcat.apache.org/tomcat-7.0-doc/config/http.html 2.
http://tomcat.apache.org/tomcat-7.0-doc/config/valve.html "
  tag "severity": "medium"
  tag "cis_id": "10.17"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  tag "audit text": "Ensure Connector elements have the enableLookups attribute
set to falser enableLookups does not exist.
# grep enableLookups $CATALINA_HOME/conf/server.xml
"
  tag "fix": "In Connector elements, set the enableLookups attribute to false
or remove it.
<Connector ... enableLookups='false' />
"
  tag "Default Value": "By default, DNS lookups are disabled.\n"
end
