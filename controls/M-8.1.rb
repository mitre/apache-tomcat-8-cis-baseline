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



control "M-8.1" do
  title "8.1 Restrict runtime access to sensitive packages (Scored)"
  desc  "package.access grants or revokes access to listed packages during
runtime. It is recommended that application access to certain packages be
restricted. Prevent web applications from accessing restricted or unknown
packages which may be malicious or dangerous to the application. "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "8.1"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  desc 'check', "Review package.access list in
$CATALINA_BASE/conf/catalina.properties to ensure only
allowed packages are defined.
"
  desc 'fix', "Edit $CATALINA_BASE/conf/catalina.properties by adding allowed
packages to the
package.access list:
package.access =
sun.,org.apache.catalina.,org.apache.coyote.,org.apache.tomcat.,
org.apache.jasper
"
  desc 'default value', "The default package.access value within
$CATALINA_BASE/conf/catalina.properties is:\npackage.access =
sun.,org.apache.catalina.,org.apache.coyote.,org.apache.tomcat.,\norg.apache.jasper"

  begin
    allowed = ["sun.", "org.apache.catalina.", "org.apache.coyote.", "org.apache.tomcat.", "org.apache.jasper."]
    cat_prop = tomcat_properties_file.read_content("#{input('tomcat_home')}/conf/catalina.properties")

    describe cat_prop['package.access'].strip.split(',') do
      it { should be_in allowed }
    end
  end
end
