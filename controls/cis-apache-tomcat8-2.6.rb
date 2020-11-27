# frozen_string_literal: true

control 'cis-apache-tomcat8-2.6' do
  title '2.6 Turn off TRACE (Scored)'
  desc  "The HTTP TRACE verb provides debugging and diagnostics information for
a given request. Diagnostic information, such as that found in the response to
a TRACE request, often contains sensitive information that may useful to an
attacker. By preventing Tomcat from providing this information, the risk of
leaking sensitive information to a potential attacker is reduced. "
  impact 0.5
  tag "ref": '1. http://tomcat.apache.org/tomcat-8.0-doc/config/http.html'
  tag "severity": 'medium'
  tag "cis_id": '2.6'
  tag "cis_control": ['No CIS Control', '6.1']
  tag "cis_level": 1
  desc 'check', "Perform the following to determine if the server platform,
as advertised in the HTTP Server
header, has been changed: Locate all Connector elements in
$CATALINA_HOME/conf/server.xml. Ensure each Connector does not have a
allowTrace attribute or if the allowTrace
attribute is not set true.
Note: Perform the above for each application hosted within Tomcat. Per
application
instances of web.xml can be found at
$CATALINA_HOME/webapps/<APP_NAME>/WEBINF/web.xml
"
  desc 'fix', "Perform the following to prevent Tomcat from accepting a TRACE
request: Set the allowTrace attributes to each Connector specified in
$CATALINA_HOME/conf/server.xml to false.
<Connector ... allowTrace='false' />
Alternatively, ensure the allowTrace attribute for each Connector specified in

$CATALINA_HOME/conf/server.xml is absent.

"
  desc 'default value', "Tomcat does not allow the TRACE HTTP verb by default.
Tomcat will only allow TRACE if\nthe allowTrace attribute is present and set to
true.\n"

  allowTraceIter = 1
  tomcat_conf = xml("#{input('tomcat_home')}/conf/server.xml")
  if tomcat_conf['Server/Service/Connector/@allowTrace'].is_a?(Array) && tomcat_conf['Server/Service/Connector/@allowTrace'].any?
    numConnectors = tomcat_conf['Server/Service/Connector'].count
    until allowTraceIter > numConnectors
      describe.one do
        describe tomcat_conf["Server/Service/Connector[#{allowTraceIter}]/@allowTrace"] do
          it { should cmp 'false' }
        end
        describe tomcat_conf["Server/Service/Connector[#{allowTraceIter}]/@allowTrace"] do
          it { should cmp [] }
        end
      end
      allowTraceIter += 1
    end
  end

  if tomcat_conf['Server/Service/Connector/@allowTrace'].none?
    describe tomcat_conf['Server/Service/Connector/@allowTrace'] do
      it { should cmp [] }
    end
  end
end
