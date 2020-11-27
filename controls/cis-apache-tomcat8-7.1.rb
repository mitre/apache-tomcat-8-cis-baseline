# frozen_string_literal: true

control 'cis-apache-tomcat8-7.1' do
  title '7.1 Application specific logging (Scored)'
  desc  "By default, java.util.logging does not provide the capabilities to
configure per-web application settings, only per VM. In order to overcome this
limitation Tomcat implements JULI as a wrapper for java.util.logging. JULI
provides additional configuration functionality so you can set each web
application with different logging specifications. Establishing per application
logging profiles will help ensure that each application’s logging verbosity is
set to an appropriate level in order to provide appropriate information when
needed for security review. "
  impact 0.5
  tag "severity": 'medium'
  tag "cis_id": '7.1'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 2
  desc 'check', "Ensure a logging.properties file is locate at
$CATALINA_BASE\\webapps\\<app_name>\\WEB-INF\\classes.
"
  desc 'fix', "Create a logging.properties file and place that into your
application WEB-INF\\classes
directory. Note: By default, installing Tomcat places a logging.properties file
in
$CATALINA_HOME\\conf. This file can be used as base for an application specific
logging
properties file
"
  desc 'default value', 'By default, per application logging is not configured.'

  apps = command("ls #{input('tomcat_home')}/webapps/").stdout.split
  ignore = %w[docs examples host-manager manager ROOT]

  ignore.each do |x|
    apps.delete(x) if apps.include?(x)
  end

  apps.each do |app|
    describe command("ls #{input('tomcat_home')}/webapps/#{app}/WEB-INF/classes/logging.properties") do
      its('stdout') { should_not eq '' }
    end
  end
end
