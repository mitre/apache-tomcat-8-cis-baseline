control "M-10.6" do
  title "10.6 Enable strict servlet Compliance (Scored)"
  desc  "The STRICT_SERVLET_COMPLIANCE influences Tomcat’s behavior in several
subtle ways. See the References below for the complete list. It is recommended
that STRICT_SERVLET_COMPLIANCE be set to true. When STRICT_SERVLET_COMPLIANCE
is set to true, Tomcat will always send an HTTP Content-type header when
responding to requests. This is significant as the behavior of web browsers is
inconsistent in the absence of the Content-type header. Some browsers will
attempt to determine the appropriate content-type by sniffing "
  impact 0.5
  tag "ref": "1.
http://tomcat.apache.org/tomcat-7.0-doc/config/systemprops.html "
  tag "severity": "medium"
  tag "cis_id": "10.6"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  tag "audit text": "Ensure the above parameter is added to the startup script
which by default is located at
$CATALINA_HOME\\bin\\catalina.sh.
"
  tag "fix": "Start Tomcat with strict compliance enabled. Add the following to
your startup script.
-Dorg.apache.catalina.STRICT_SERVLET_COMPLIANCE=true
"
  tag "Default Value": "By default, this configuration parameter is not
present.\n"
end
