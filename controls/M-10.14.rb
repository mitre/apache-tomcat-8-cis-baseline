control "M-10.14" do
  title "10.14 Do not run applications as privileged (Scored)"
  desc  "Setting the privileged attribute for an application changes the class
loader to the Server class loader instead of the Shared class loader. Running
an application in privileged mode allows an application to load the manager
libraries. "
  impact 0.5
  tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/config/context.html"
  tag "severity": "medium"
  tag "cis_id": "10.14"
  tag "cis_control": ["No CIS Control", "6.1"]
  tag "cis_level": 1
  desc 'check', "Ensure all context.xml have the privileged attribute set
to false or privileged does not exist.
# find . -name context.xml | xargs grep 'privileged'
"
  desc 'fix', "In all context.xml, set the privileged attribute to false unless
it is required like the
manager application:
<Context ... privileged=”false” />
"
  desc 'default value', "By default, privileged has a value of false.\n"

  begin
    describe.one do
      describe command("find #{input('tomcat_app_dir')} -name context.xml | xargs grep 'privileged'") do
        its('stdout') { should eq ''}
      end
      describe command ("find #{input('tomcat_app_dir')} -name context.xml | xargs grep 'privileged'") do
        its('stdout') { should_not include 'privileged="true"' }
      end
    end
  end
end
