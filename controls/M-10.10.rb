# frozen_string_literal: true

control 'M-10.10' do
  title '10.10 Configure connectionTimeout (Scored)'
  desc  "The connectionTimeout setting allows Tomcat to close idle sockets
after a specific amount of time to save system resources. Closing idle sockets
reduces system resource usage thus can provide better performance and help
protect against Denial of Service attacks. "
  impact 0.5
  tag "ref": '1. https://tomcat.apache.org/tomcat-8.0-doc/config/http.html'
  tag "severity": 'medium'
  tag "cis_id": '10.10'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 2
  desc 'check', "Locate each connectionTimeout setting in
$CATALINA_HOME/conf/server.xml and verify
the setting is correct.
# grep connectionTimeout $CATALINA_HOME/conf/server.xml
"
  desc 'fix', "Within $CATALINA_HOME/conf/server.xml ensure each connector is
configured to the
connectionTimeout setting that is optimal based on hardware resources, load,
and number
of concurrent connections.
connectionTimeout='60000'
"
  desc 'default value', "connectionTimeout is set to 60000\n"

  tomcat_conf = xml(input('tomcat_conf_server'))

  if tomcat_conf['Server/Service/Connector/attribute::connectionTimeout'].is_a?(Array)
    tomcat_conf['Server/Service/Connector/attribute::connectionTimeout'].each do |x|
      describe x do
        it { should eq '60000' }
      end
    end
  else
    describe xml(tomcat_conf['Server/Service/Connector/attribute::connectionTimeout']) do
      it { should eq '60000' }
    end
  end
end
