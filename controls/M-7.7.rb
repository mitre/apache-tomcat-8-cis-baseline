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



control "M-7.7" do
  title "7.7 Configure log file size limit (Scored)"
  desc  "By default, the logging.properties file will have no defined limit for
the log file size. This is a potential denial of service attack as it would be
possible to fill a drive or partition containing the log files. Establishing a
maximum log size that is smaller than the partition size will help mitigate the
risk of an attacker maliciously exhausting disk space. "
  impact 0.5
  tag "ref": "1.
https://docs.oracle.com/javase/8/docs/api/java/util/logging/FileHandler.html"
  tag "severity": "medium"
  tag "cis_id": "7.7"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  desc 'check', "Validate the max file limit is not greater than the size
of the partition where the log files are
stored.
"
  desc 'fix', "Create the following entry in your logging.properties file. This
field is specified in bytes.
java.util.logging.FileHandler.limit=10000
"
  desc 'default value', "No limit by default.\n"

  begin
    cat_prop = tomcat_properties_file.read_content("#{input('tomcat_home')}/conf/catalina.properties")
    describe cat_prop['java.util.logging.FileHandler.limit'] do
      it { should cmp '10000' }
    end
  end
end
