# -*- encoding : utf-8 -*-
control "M-1.2" do
  title "1.2 Disable Unused Connectors (Not Scored)"
  desc  "The default installation of Tomcat includes connectors with default
settings. These are traditionally set up for convenience. It is best to remove
these connectors and enable only what is needed. Improperly configured or
unnecessarily installed Connectors may lead to a security exposure. "
  impact 0.5
  tag "ref": "1.
http://tomcat.apache.org/tomcat-8.0-doc/config/http.html#Connector_Comparison"
  tag "severity": "medium"
  tag "cis_id": "1.2"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 2
  desc 'check', "Perform the following to identify configured Connectors:
Execute the following command to find configured Connectors. Ensure only those
required
are present and not commented out:
$ grep “Connector” $CATALINA_HOME/conf/server.xml
"
  desc 'fix', "Perform the following to disable unused Connectors: Within
$CATALINA_HOME/conf/server.xml, remove or comment each unused Connector.
For example, to disable an instance of the HTTPConnector, remove the following:

<Connector className='org.apache.catalina.connector.http.HttpConnector'
...
connectionTimeout='60000'/>
"
  desc 'default value', "$CATALINA_HOME/conf/server.xml, has the following
connectors defined by default:\nA non-SSL Connector bound to port 8080\nAn AJP
1.3 Connector bound to port 8009\n\n"

  # @TODO a resource needs to be created to be able to query more than just the
  # port but also the full connector's information
  ports = ["8084", "8009"]

  tomcat_conf = xml("#{input('tomcat_home')}/conf/server.xml")

  iter = 1
  if tomcat_conf['Server/Service/Connector/@port'].is_a?(Array)
    numConnectors = tomcat_conf['Server/Service/Connector'].count
    until iter > numConnectors do
       puts("Inside the loop i = #{iter}" )
       describe tomcat_conf["Server/Service/Connector[#{iter}]/@port"] do
         it { should be_in ports }
       end
       iter +=1;
    end
  end
end
