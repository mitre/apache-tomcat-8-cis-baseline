# frozen_string_literal: true

control 'M-6.2' do
  title "6.2 Ensure SSLEnabled is set to True for Sensitive Connectors (Not
Scored)"
  desc  "The SSLEnabled setting determines if SSL is enabled for a specific
Connector. It is recommended that SSL be utilized for any Connector that sends
or receives sensitive information, such as authentication credentials or
personal information. The SSLEnabled setting ensures SSL is active, which will
in-turn ensure the confidentiality and integrity of sensitive information while
in transit. "
  impact 0.5
  ref 'http://tomcat.apache.org/tomcat-8.0-doc/ssl-howto.html'
  ref 'https://tomcat.apache.org/tomcat-8.0-doc/config/http.html'
  tag "severity": 'medium'
  tag "cis_id": '6.2'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 1
  desc 'check', "Review server.xml and ensure all Connectors sending or
receiving sensitive information
have the SSLEnabled attribute set to true.
"
  desc 'fix', "In server.xml, set the SSLEnabled attribute to true for each
Connector that sends or
receives sensitive information
<Connector
…
SSLEnabled='true'
…
/>
"
  desc 'default value', "SSLEnabled is set to false.\n"

  tomcat_server = tomcat_server_xml(input('tomcat_conf_server').to_s)

  # remove any non secure connectors first
  tomcat_server.params.each do |connector|
    tomcat_server.params.delete(connector) if connector[:protocol] == 'HTTP/1.1' || connector[:protocol] == 'AJP/1.3'
  end

  # check remaining connectors for sslenable attribute
  tomcat_server.params.each do |connector|
    describe connector do
      its([:sslenable]) { should cmp 'true' }
    end
  end
end
