# frozen_string_literal: true

control 'cis-apache-tomcat8-2.4' do
  title "2.4 Disable X-Powered-By HTTP Header and Rename the Server Value for
all Connectors (Scored)"
  desc  "The xpoweredBy setting determines if Apache Tomcat will advertise its
presence via the XPowered-By HTTP header. It is recommended that this value be
set to false. The server attribute overrides the default value that is sent
down in the HTTP header further masking Apache Tomcat. Preventing Tomcat from
advertising its presence in this manner may make it harder for attackers to
determine which vulnerabilities affect the server platform. "
  impact 0.5
  tag "ref": '1. http://tomcat.apache.org/tomcat-8.0-doc/config/http.html'
  tag "severity": 'medium'
  tag "cis_id": '2.4'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 2
  desc 'check', "Perform the following to determine if the server platform,
as advertised in the HTTP Server
header, has been changed: Locate all Connector elements in
$CATALINA_HOME/conf/server.xml. Ensure each Connector has a server attribute
and that the server attribute does not
reflect Apache Tomcat. Also, make sure that the xpoweredBy attribute is NOT set
to true.
"
  desc 'fix', "Perform the following to prevent Tomcat from advertising its
presence via the XPoweredBy HTTP header. Add the xpoweredBy attribute to each
Connector specified in
$CATALINA_HOME/conf/server.xml. Set the xpoweredBy attributes value to false.
<Connector
...
xpoweredBy='false' />
Alternatively, ensure the xpoweredBy attribute for each Connector specified in

$CATALINA_HOME/conf/server.xml is absent.
 Add the server attribute to each Connector specified in
$CATALINA_HOME/conf/server.xml. Set the server attribute value to anything
except a
blank string.
"
  desc 'default value', "The default value is false.\n"

  tomcat_conf = xml("#{input('tomcat_home')}/conf/server.xml")

  serverIter = 1
  if tomcat_conf['Server/Service/Connector/@server'].is_a?(Array)
    numConnectors = tomcat_conf['Server/Service/Connector'].count
    until serverIter > numConnectors
      describe tomcat_conf["Server/Service/Connector[#{serverIter}]/@server"] do
        it { should_not eq [] }
        it { should_not cmp 'Apache Tomcat' }
      end
      serverIter += 1
    end
  end

  xpoweredByIter = 1
  if tomcat_conf['Server/Service/Connector/@xpoweredBy'].is_a?(Array) && tomcat_conf['Server/Service/Connector/@xpoweredBy'].any?
    numConnectors = tomcat_conf['Server/Service/Connector'].count
    until xpoweredByIter > numConnectors
      describe.one do
        describe tomcat_conf["Server/Service/Connector[#{xpoweredByIter}]/@xpoweredBy"] do
          it { should cmp 'false' }
        end
        describe tomcat_conf["Server/Service/Connector[#{xpoweredByIter}]/@xpoweredBy"] do
          it { should cmp [] }
        end
      end
      xpoweredByIter += 1
    end
  end
  if tomcat_conf['Server/Service/Connector/@xpoweredBy'].none?
    describe tomcat_conf['Server/Service/Connector/@xpoweredBy'] do
      it { should cmp [] }
    end
  end
end
