# frozen_string_literal: true

control 'cis-apache-tomcat8-10.3' do
  title '10.3 Restrict manager application (Not Scored)'
  desc  "Limit access to the manager application to only those with a required
needed. Limiting access to the least privilege required will ensure only those
people with required need have access to a resource. The manager application
should be limited to only administrators. "
  impact 0.5
  ref 'https://tomcat.apache.org/tomcat-8.0-doc/config/valve.html'
  ref 'https://tomcat.apache.org/tomcat-8.0-doc/manager-howto.html'
  tag "severity": 'medium'
  tag "cis_id": '10.3'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 2
  desc 'check', "Review
$CATALINA_BASE/conf/[enginename]/[hostname]/manager.xml to ascertain that
the RemoteAddrValve option is uncommented and configured to only allow access
to
systems required to connect.
"
  desc 'fix', "For the manager application, edit
$CATALINA_BASE/conf/[enginename]/[hostname]/manager.xml, and add the bolded
line:
<Context path='/manager' docBase='${catalina.home}/webapps/manager' debug='0'
privileged='true'>
<Valve className='org.apache.catalina.valves.RemoteAddrValve'
allow='127\\.0\\.0\\.1'/>
<!-- Link to the user database we will get roles from -->
<ResourceLink name='users' global='UserDatabase'
type='org.apache.catalina.UserDatabase'/>
</Context>
Add hosts, comma separated, which are allowed to access the admin application.

Note: The RemoteAddrValve property expects a regular expression, therefore
periods and
other regular expression meta-characters must be escaped.
"
  desc 'default value', "By default, this setting is not present\n"
 
  unless command("find #{input('tomcat_home')}/conf/ -name manager.xml").stdout.empty?
    manager_xml = command("find #{input('tomcat_home')}/conf/ -name manager.xml").stdout.split.each do |man_xml|
      describe xml(man_xml) do
        its('Context/Valve/attribute::className') { should include 'org.apache.catalina.valves.RemoteAddrValve' }
        its('Context/Valve/attribute::allow') { should_not cmp [] }
      end
    end
  else
    describe "No manager.xml files were found in #{input('tomcat_home')}" do
      skip "No manager.xml files were found in your tomcat config at #{input('tomcat_home')}/conf. Manually review 
      that the Manager Application is only accessable to those requiring access to the application"
    end
  end
end

