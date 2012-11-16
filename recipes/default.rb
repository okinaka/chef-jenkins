include_recipe "java"

case node["platform_family"]
when "debian"
  include_recipe "apt"

  apt_repository "jenkins" do
    uri "http://pkg.jenkins-ci.org/debian"
    key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
    components ["binary/"]
    action :add
  end

when "rhel"
  include_recipe "yum"

  yum_key "RPM-GPG-KEY-jenkins" do
    url "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
    action :add
  end

  yum_repository "jenkins" do
    description "Jenkins Official repo"
    url "http://pkg.jenkins-ci.org/redhat"
    key "RPM-GPG-KEY-jenkins"
    action :add
  end
end

package "jenkins"

