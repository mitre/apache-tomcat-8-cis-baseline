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



control "M-9.1" do
  title "9.1 Starting Tomcat with Security Manager (Scored)"
  desc  "Configure application to run in a sandbox using the Security Manager.
The Security Manager restricts what classes Tomcat can access thus protecting
your server from mistakes, Trojans, and malicious code. By running Tomcat with
the Security Manager, applications are run in a sandbox which can prevent
untrusted code from accessing files on the file system. "
  impact 0.5
  tag "ref": "1.
http://tomcat.apache.org/tomcat-8.0-doc/security-manager-howto.html"
  tag "severity": "medium"
  tag "cis_id": "9.1"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  desc 'check', "Review the startup configuration in /etc/init.d for Tomcat
to ascertain if Tomcat is started
with the -security option
"
  desc 'fix', "The security policies implemented by the Java SecurityManager are
configured in the
$CATALINA_HOME/conf/catalina.policy file. Once you have configured the
catalina.policy
file for use with a SecurityManager, Tomcat can be started with a
SecurityManager in place
by using the --security option:
$ $CATALINA_HOME/bin/catalina.sh start -security (Unix)
C:\\> %CATALINA_HOME%\\bin\\catalina start -security (Windows)
"
  desc 'default value', "By default, the -security option is not utilized.\n"

  begin
    describe parse_config_file("/etc/systemd/system/tomcat.service") do
      its('Service.ExecStart') { should cmp "#{input('tomcat_home')}/bin/startup.sh -security" }
    end
  end
end
