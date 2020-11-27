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



control "M-6.4" do
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
  tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/ssl-howto.html 2.
http://tomcat.apache.org/tomcat-8.0-doc/config/http.html"
  tag "severity": "medium"
  tag "cis_id": "6.4"
  tag "cis_control": ["No CIS Control", "6.1"]
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

  begin
    tomcat_server = tomcat_server_xml("#{TOMCAT_CONF_SERVER}")

    tomcat_server.params.each do |connector|
      describe connector do
        if connector[:sslenable] == "true"
          its([:secure]) { should cmp 'true' }
        end
      end
    end
  end
end
