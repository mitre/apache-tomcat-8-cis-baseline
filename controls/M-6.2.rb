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



control "M-6.2" do
  title "6.2 Ensure SSLEnabled is set to True for Sensitive Connectors (Not
Scored)"
  desc  "The SSLEnabled setting determines if SSL is enabled for a specific
Connector. It is recommended that SSL be utilized for any Connector that sends
or receives sensitive information, such as authentication credentials or
personal information. The SSLEnabled setting ensures SSL is active, which will
in-turn ensure the confidentiality and integrity of sensitive information while
in transit. "
  impact 0.5
  tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/ssl-howto.html 2.
https://tomcat.apache.org/tomcat-8.0-doc/config/http.html"
  tag "severity": "medium"
  tag "cis_id": "6.2"
  tag "cis_control": ["No CIS Control", "6.1"]
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

  begin
    tomcat_server = tomcat_server_xml("#{TOMCAT_CONF_SERVER}")

    # remove any non secure connectors first
    tomcat_server.params.each do |connector|
      if connector[:protocol] == "HTTP/1.1" || connector[:protocol] == "AJP/1.3"
        tomcat_server.params.delete(connector)
      end
    end

    # check remaining connectors for sslenable attribute
    tomcat_server.params.each do |connector|
      describe connector do
        its([:sslenable]) { should cmp 'true' }
      end
    end
  end
end
