# frozen_string_literal: true

control 'cis-apache-tomcat8-1.1' do
  title '1.1 Remove extraneous files and directories (Scored)'
  desc  "The installation may provide example applications, documentation, and
other directories which may not serve a production use. Removing sample
resources is a defense in depth measure that reduces potential exposures
introduced by these resources. "
  impact 0.5
  tag "severity": 'medium'
  tag "cis_id": '1.1'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 2
  desc 'check', "Perform the following to determine the existence of
extraneous resources:
List all files extraneous files. The following should yield no output:
$ ls -l $CATALINA_HOME/webapps/docs \\
$CATALINA_HOME/webapps/examples
"
  desc 'fix', "Perform the following to remove extraneous resources:
The following should yield no output:
$ rm -rf $CATALINA_HOME/webapps/docs \\
$CATALINA_HOME/webapps/examples
If the Manager application is not utilized, also remove the following
resources:
$ rm –rf $CATALINA_HOME/webapps/host-manager \\
$CATALINA_HOME/webapps/manager \\
$CATALINA_HOME/conf/Catalina/localhost/manager.xml

"
  desc 'default value', "\"docs\", \"examples\", \"manager\" and
\"host-manager\" are default web applications shipped\nwith Tomcat."

  input('tomcat_extraneous_resource_list').to_s.each do |app|
    describe command("ls -l #{input('tomcat_home')}/#{app}") do
      its('stdout.strip') { should eq '' }
    end
  end
end
