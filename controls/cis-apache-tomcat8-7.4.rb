# frozen_string_literal: true

control 'cis-apache-tomcat8-7.4' do
  title '7.4 Ensure directory in context.xml is a secure location (Scored)'
  desc  "The directory attribute tells Tomcat where to store logs. It is
recommended that the location pointed to by the directory attribute be secured.
Securing the log location will help ensure the integrity and confidentiality of
web application activity. "
  impact 0.5
  tag "severity": 'medium'
  tag "cis_id": '7.4'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 1
  desc 'check', "Review the permissions of the directory specified by the
directory setting to ensure the
permissions are o-rwx and owned by tomcat_admin:tomcat:
# grep directory context.xml
# ls –ld <log location>
"
  desc 'fix', "Perform the following: Add the following statement into the
$CATALINA_BASE\\webapps\\<app-name>\\METAINF\\context.xml file if it does not
already exist.
<Valve className='org.apache.catalina.valves.AccessLogValve'
directory='$CATALINA_HOME/logs/'
prefix='access_log' fileDateFormat='yyyy-Mcis-apache-tomcat8-dd.HH' suffix='.log' pattern='%t %H

cookie:%{SESSIONID}c request:%{SESSIONID}r %m %U %s %q %r'
/> Set the location pointed to by the directory attribute to be owned by
tomcat_admin:tomcat with permissions of o-rwx.
# chown tomcat_admin:tomcat $CATALINA_HOME/logs
# chmod o-rwx $CATALINA_HOME/logs
"
  desc 'default value', 'Does not exist by default'

  context_xml = command("ls #{input('tomcat_home')}/webapps/*/META-INF/context.xml").stdout.split.each do |web_file|
    describe xml(web_file) do
      its('Context/Valve/attribute::className') { should include 'org.apache.catalina.valves.AccessLogValve' }
      its('Context/Valve/attribute::directory') { should cmp "#{input('tomcat_home')}/logs/" }
      its('Context/Valve/attribute::prefix') { should cmp 'access_log' }
      its('Context/Valve/attribute::fileDateFormat') { should cmp 'yyyy-Mcis-apache-tomcat8-dd.HH' }
      its('Context/Valve/attribute::suffix') { should cmp '.log' }
      its('Context/Valve/attribute::pattern') { should cmp '%h %t %H cookie:%{SESSIONID}c request:%{SESSIONID}r %m %U %s %q %r' }
    end
  end
  describe directory("#{input('tomcat_home')}/logs") do
    its('group') { should cmp input('tomcat_group') }
    its('owner') { should cmp input('tomcat_admin') }
    it { should_not be_more_permissive_than('0770') }
  end
end
