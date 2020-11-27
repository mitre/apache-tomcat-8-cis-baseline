# -*- encoding : utf-8 -*-
# frozen_string_literal: true

control 'M-6.3' do
  title '6.3 Ensure scheme is set accurately (Scored)'
  desc  "The scheme attribute is used to indicate to callers of
request.getScheme() which scheme is in use by the Connector. Ensure the scheme
attribute is set to http for Connectors operating over HTTP. Ensure the scheme
attribute is set to https for Connectors operating of HTTPS. Maintaining parity
between the scheme in use by the Connector and advertised by
request.getScheme() will ensure applications built on Tomcat have an accurate
depiction of the context and security guarantees provided to them. "
  impact 0.5
  tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/ssl-howto.html 2.
http://tomcat.apache.org/tomcat-8.0-doc/config/http.html"
  tag "severity": 'medium'
  tag "cis_id": '6.3'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 1
  desc 'check', "Review server.xml to ensure the Connector’s scheme
attribute is set to http for Connectorsperating over HTTP. Also ensure the
Connector’s scheme attribute is set to https for
Connectors operating over HTTPS.
"
  desc 'fix', "In server.xml, set the Connector’s scheme attribute to http for
Connectors operating over
HTTP. Set the Connector’s scheme attribute to https for Connectors operating of
HTTPS.
<Connector
…
scheme='https'
…
/>
"
  desc 'default value', "The scheme attribute is set to http.\n"

  tomcat_server = tomcat_server_xml(input('tomcat_conf_server').to_s)

  tomcat_server.params.each do |connector|
    describe connector do
      its([:scheme]) { should cmp 'https' } if connector[:sslenable] == 'true'
    end
  end
end
