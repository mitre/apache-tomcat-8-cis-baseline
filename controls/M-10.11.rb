control "M-10.11" do
  title "10.11 Configure maxHttpHeaderSize (Scored)"
  desc  "The maxHttpHeaderSize limits the size of the request and response
headers defined in bytes. If not specified, the default is 8192 bytes. Limiting
the size of the header request can help protect against Denial of Service
requests. "
  impact 0.5
  tag "ref": "1. http://tomcat.apache.org/tomcat-7.0-doc/config/http.html "
  tag "severity": "medium"
  tag "cis_id": "10.11"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  tag "audit text": "Locate each maxHttpHeaderSize setting in
$CATALINA_HOME/conf/server.xml and verify
that they are set to 8192.
# grep maxHttpHeaderSize $CATALINA_HOME/conf/server.xml
"
  tag "fix": "Within $CATALINA_HOME/conf/server.xml ensure each connector is
configured to the
appropriate maxHttpHeaderSize setting.
maxHttpHeaderSize=”8192”
"
  tag "Default Value": "maxHttpHeaderSize is set to 8192\n"
end
