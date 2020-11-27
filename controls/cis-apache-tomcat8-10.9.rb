# frozen_string_literal: true

control 'cis-apache-tomcat8-10.9' do
  title '10.9 Do not allow custom header status messages (Scored)'
  desc  "Being able to specify custom status messages opens up the possibility
for additional headers to be injected. If custom header status messages are
required, make sure it is only in US-ASCII and does not include any
user-supplied data. Allowing user-supplied data into a header allows the
possibility of XSS. "
  impact 0.5
  ref 'http://tomcat.apache.org/tomcat-8.0-doc/config/systemprops.html'
  tag "severity": 'medium'
  tag "cis_id": '10.9'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 2
  desc 'check', "Ensure the above parameter is added to the startup script
which by default is located at
$CATALINA_HOME/bin/catalina.sh.
"
  desc 'fix', "Start Tomcat with USE_CUSTOM_STATUS_MSG_IN_HEADER set to false.
Add the following
to your startup script.
-Dorg.apache.coyote.USE_CUSTOM_STATUS_MSG_IN_HEADER=false
"
  desc 'default value', "By default, allowing custom header status messages is
set to false.\n"

  cat_prop = tomcat_properties_file.read_content("#{input('tomcat_home')}/conf/catalina.properties")

  describe cat_prop['org.apache.coyote.USE_CUSTOM_STATUS_MSG_IN_HEADER'] do
    it { should cmp 'false' }
  end
end
