control "M-10.16" do
  title "10.16 Do not resolve hosts on logging valves (Scored)"
  desc  "Setting enableLookups to true on Connector requires a DNS look-up
before logging the information. This adds additional resources when logging.
Allowing enableLookups adds additional overhead that is rarely needed. "
  impact 0.5
  tag "ref": "1. https://tomcat.apache.org/tomcat-8.0-doc/config/valve.html 2.
https://tomcat.apache.org/tomcat-8.0-doc/config/http.html"
  tag "severity": "medium"
  tag "cis_id": "10.16"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  desc 'check', "Ensure Connector elements have the enableLookups attribute
set to falser enableLookups does not exist.
# grep enableLookups $CATALINA_HOME/conf/server.xml
"
  desc 'fix', "In Connector elements, set the enableLookups attribute to false
or remove it.
<Connector ... enableLookups='false' />
"
  desc 'default value', "By default, DNS lookups are disabled.\n"

  begin
    describe command("grep enableLookups #{input('tomcat_conf_server')}") do
      its('stdout') { should eq '' }
    end
  end
end
