# frozen_string_literal: true

control 'cis-apache-tomcat8-10.18' do
  title '10.18 Setting Security Lifecycle Listener (Scored)'
  desc  "The Security Lifecycle Listener performs a number of security checks
when Tomcat starts and prevents Tomcat from starting if they fail. Enable the
Security Lifecycle Listener can Enforce a blacklist of OS users that must not
be used to start Tomcat. set the least restrictive umask before Tomcat start "
  impact 0.5
  ref 'https://tomcat.apache.org/tomcat-8.0doc/config/listeners.html#Security_Lifecycle_Listener__org.apache.catalina.security.SecurityListener'
  tag "severity": 'medium'
  tag "cis_id": '10.18'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 1
  desc 'check', "Review server.xml to ensure the Security Lifecycle
Listener element is uncommented and
checkedOsUsers, minimumUmask attributes are set with expected value.
"
  desc 'fix', "To enable it uncomment the listener in
$CATALINA_BASE/conf/server.xml. If the operating
system supports umask then the line in $CATALINA_HOME/bin/catalina.sh that
obtains the
umask also needs to be uncommented.
Within Server elements add:
checkedOsUsers: A comma separated list of OS users that must not be used to
start
Tomcat. If not specified, the default value of root is used.
minimumUmask: The least restrictive umask that must be configured before Tomcat

will start. If not specified, the default value of 0007 is used.
<Listener className='org.apache.catalina.security.SecurityListener'
checkedOsUsers='alex,bob' minimumUmask='0007' />
"
  desc 'default value', "The Security Lifecycle Listener is not enabled by
default. For checkedOsUsers, If not\nspecified, the default value of root is
used. For minimumUmask, if not specified, the default\nvalue of 0007 is
used.\n\n"

  describe xml(input('tomcat_conf_server')) do
    its('Server/Listener/attribute::className') { should include 'org.apache.catalina.security.SecurityListener' }
    its('Server/Listener/attribute::checkedOsUsers') { should include 'root' }
    its('Server/Listener/attribute::minimumUmask') { should cmp '0007' }
  end
end
