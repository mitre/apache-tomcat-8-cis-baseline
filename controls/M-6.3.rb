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



control "M-6.3" do
  title "6.3 Ensure scheme is set accurately (Scored)"
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
  tag "severity": "medium"
  tag "cis_id": "6.3"
  tag "cis_control": ["No CIS Control", "6.1"]
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

  begin
    tomcat_server = tomcat_server_xml("#{TOMCAT_CONF_SERVER}")

    tomcat_server.params.each do |connector|
      describe connector do
        if connector[:sslenable] == "true"
          its([:scheme]) { should cmp 'https' }
        end
      end
    end
  end
end
