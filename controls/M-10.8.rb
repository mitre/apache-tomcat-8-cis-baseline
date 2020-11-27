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



control "M-10.8" do
  title "10.8 Do not allow additional path delimiters (Scored)"
  desc  "Being able to specify different path-delimiters on Tomcat creates the
possibility that an attacker can access applications that were previously
blocked a proxy like mod_proxy Allowing additional path-delimiters allows for
an attacker to get an application or area that was not previously visible. "
  impact 0.5
  tag "ref": "1.
http://tomcat.apache.org/tomcat-8.0-doc/config/systemprops.html"
  tag "severity": "medium"
  tag "cis_id": "10.8"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  desc 'check', "Ensure the above parameters are added to the startup
script which by default is located at
$CATALINA_HOME/bin/catalina.sh.
"
  desc 'fix', "Start Tomcat with ALLOW_BACKSLASH set to false and
ALLOW_ENCODED_SLASH set to
false. Add the following to your startup script.
-Dorg.apache.catalina.connector.CoyoteAdapter.ALLOW_BACKSLASH=false
-Dorg.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=false
"
  desc 'default value', "By default, allowing additional parameters is set to
false.\n"

  begin
    describe parse_config_file('/usr/share/tomcat/conf/catalina.properties') do
      its('ALLOW_BACKSLASH') { should eq 'false' }
    end

    describe parse_config_file('/usr/share/tomcat/conf/catalina.properties') do
      its('ALLOW_ENCODED_SLASH') { should eq 'false' }
    end
  end
end
