# frozen_string_literal: true

control 'cis-apache-tomcat8-6.5' do
  title '6.5 Ensure SSL Protocol is set to TLS for Secure Connectors (Scored)'
  desc  "The sslProtocol setting determines which protocol Tomcat will use to
protect traffic. It is recommended that sslProtocol attribute be set to TLS.
The TLS protocol does not contain weaknesses that affect other secure transport
protocols, such as SSLv1 or SSLv2. Therefore, TLS is leveraged to protect the
confidentiality and integrity of data while in transit. "
  impact 0.5
  ref 'http://tomcat.apache.org/tomcat-8.0-doc/ssl-howto.html'
  ref 'http://tomcat.apache.org/tomcat-8.0-doc/config/http.html'
  tag "severity": 'medium'
  tag "cis_id": '6.5'
  tag "cis_control": ['No CIS Control', '6.1']
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

  tomcat_server = tomcat_server_xml(input('tomcat_conf_server').to_s)

  tomcat_server.params.each do |connector|
    describe connector do
      its([:sslprotocol]) { should cmp 'TLS' } if connector[:sslenable] == 'true'
    end
  end
end
