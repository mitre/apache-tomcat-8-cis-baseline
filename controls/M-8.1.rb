# -*- encoding : utf-8 -*-
# frozen_string_literal: true

control 'M-8.1' do
  title '8.1 Restrict runtime access to sensitive packages (Scored)'
  desc  "package.access grants or revokes access to listed packages during
runtime. It is recommended that application access to certain packages be
restricted. Prevent web applications from accessing restricted or unknown
packages which may be malicious or dangerous to the application. "
  impact 0.5
  tag "severity": 'medium'
  tag "cis_id": '8.1'
  tag "cis_control": ['No CIS Control', '6.1']
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

  allowed = ['sun.', 'org.apache.catalina.', 'org.apache.coyote.', 'org.apache.tomcat.', 'org.apache.jasper.']
  cat_prop = tomcat_properties_file.read_content("#{input('tomcat_home')}/conf/catalina.properties")

  describe cat_prop['package.access'].strip.split(',') do
    it { should be_in allowed }
  end
end
