# frozen_string_literal: true

control 'cis-apache-tomcat8-6.4' do
  title "6.4 Ensure secure is set to true only for SSL-enabled Connectors
(Scored)"
  desc  "The secure attribute is used to convey Connector security status to
applications operating over the Connector. This is typically achieved by
calling request.isSecure(). Ensure the secure attribute is only set to true for
Connectors operating with the SSLEnabled attribute set to true. Accurately
reporting the security state of the Connector will help ensure that
applications built on Tomcat are not unknowingly relying on security controls
that are not in place. "
  impact 0.5
  ref ' http://tomcat.apache.org/tomcat-8.0-doc/ssl-howto.html'
  ref 'http://tomcat.apache.org/tomcat-8.0-doc/config/http.html'
  tag "severity": 'medium'
  tag "cis_id": '6.4'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 1
  desc 'check', "Review server.xml and ensure the secure attribute is set
to true for those Connectors
having SSLEnabled set to true. Also, ensure the secure attribute set to false
for those
Connectors having SSLEnabled set to false.
"
  desc 'fix', "For each Connector defined in server.xml, set the secure
attribute to true for those
Connectors having SSLEnabled set to true. Set the secure attribute set to false
for those
Connectors having SSLEnabled set to false.
<Connector SSLEnabled='true'
…
secure='true'
…
/>
"
  desc 'default value', "The secure attribute is set to false.\n"

  tomcat_server = tomcat_server_xml(input('tomcat_conf_server').to_s)

  tomcat_server.params.each do |connector|
    describe connector do
      its([:secure]) { should cmp 'true' } if connector[:sslenable] == 'true'
    end
  end
end
