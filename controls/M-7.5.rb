control "M-7.5" do
  title "7.5 Ensure pattern in context.xml is correct (Scored)"
  desc  "The pattern setting informs Tomcat what information should be logged
per applications. At a minimum, enough information to uniquely identify a
request, what was requested, where the requested originated from, and when the
request occurred should be logged. The following will log the request date and
time (%t), the requested URL (%U), the remote IP address (%a), the local IP
address (%A), the request method (%m), the local port (%p), query string, if
present, (%q), and the HTTP status code of the response (%s). pattern='%t %U %a
%A %m %p %q %s” The level of logging detail prescribed will assist in
identifying correlating security events or incidents. "
  impact 0.5
  tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/config/valve.html"
  tag "severity": "medium"
  tag "cis_id": "7.5"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  desc 'check', "Review the pattern settings to ensure it contains all the
variables required by the
installation.
# grep pattern $CATALINA_BASE\\webapps\\<app-name>\\META-INF\\context.xml
"
  desc 'fix', "Add the following statement into the
$CATALINA_BASE\\webapps\\<app-name>\\METAINF\\context.xml file if it does not
already exist.
<Valve
className='org.apache.catalina.valves.AccessLogValve'
directory='$CATALINA_HOME/logs/'
prefix='access_log' fileDateFormat='yyyy-MM-dd.HH' suffix='.log'
pattern='%h %t %H cookie:%{SESSIONID}c request:%{SESSIONID}r %m %U %s %q %r'
/>
"
  desc 'default value', "Does not exist by default\n"

  begin
    context_xml = command("ls #{input('tomcat_home')}/webapps/*/META-INF/context.xml").stdout.split.each do |web_file|
      describe xml(web_file) do
        its('Context/Valve/attribute::className') { should include "org.apache.catalina.valves.AccessLogValve" }
        its('Context/Valve/attribute::directory') { should cmp '$CATALINA_HOME/logs/' }
        its('Context/Valve/attribute::prefix') { should cmp 'access_log' }
        its('Context/Valve/attribute::fileDateFormat') { should cmp 'yyyy-MM-dd.HH' }
        its('Context/Valve/attribute::suffix') { should cmp '.log' }
        its('Context/Valve/attribute::pattern') { should cmp '%h %t %H cookie:%{SESSIONID}c request:%{SESSIONID}r %m %U %s %q %r' }
      end
    end
  end
end
