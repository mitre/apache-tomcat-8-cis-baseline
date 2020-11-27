input('tomcat_service_name')= input(
  'tomcat_service_name',
  description: 'Name of Tomcat service',
  value: 'tomcat'
)

TOMCAT_CONF_SERVER= input(
  'tomcat_conf_server',
  description: 'Path to tomcat server.xml',
  value: '/usr/share/tomcat/conf/server.xml'
)

input('tomcat_app_dir')= input(
  'tomcat_app_dir',
  description: 'location of tomcat app directory',
  value: '/var/lib/tomcat'
)

TOMCAT_CONF_WEB= input(
  'tomcat_conf_web',
  description: 'location of tomcat web.xml',
  value: '/usr/share/tomcat/conf/web.xml'
)

input('tomcat_home')= input(
  'tomcat_home',
  description: 'location of tomcat home directory',
  value: '/usr/share/tomcat'
)

TOMCAT_LOGS= input(
  'tomcat_logs',
  description: 'location of tomcat log directory',
  value: '/usr/share/tomcat/logs'
)



control "M-6.5" do
  title "6.5 Ensure SSL Protocol is set to TLS for Secure Connectors (Scored)"
  desc  "The sslProtocol setting determines which protocol Tomcat will use to
protect traffic. It is recommended that sslProtocol attribute be set to TLS.
The TLS protocol does not contain weaknesses that affect other secure transport
protocols, such as SSLv1 or SSLv2. Therefore, TLS is leveraged to protect the
confidentiality and integrity of data while in transit. "
  impact 0.5
  tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/ssl-howto.html 2.
http://tomcat.apache.org/tomcat-8.0-doc/config/http.html"
  tag "severity": "medium"
  tag "cis_id": "6.5"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  desc 'check', "Review server.xml to ensure the sslProtocol attribute is
set to TLS for all Connectors having
SSLEngine set to on.
"
  desc 'fix', "In server.xml, set the sslProtocol attribute to 'TLS' for
Connectors having SSLEnabled set
to true.
<Connector
…
sslProtocol='TLS'
…
/>
"
  desc 'default value', "If not specified, the default value of \"TLS\" will be
used.\n"

  begin
    tomcat_server = tomcat_server_xml("#{TOMCAT_CONF_SERVER}")

    tomcat_server.params.each do |connector|
      describe connector do
        if connector[:sslenable] == "true"
          its([:sslprotocol]) { should cmp 'TLS' }
        end
      end
    end
  end
end
