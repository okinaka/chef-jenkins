include_recipe "java"

user node["jenkins"]["server"]["user"] do
  home node["jenkins"]["server"]["home"]
end

directory node["jenkins"]["server"]["home"] do
  recursive true
  owner node["jenkins"]["server"]["user"]
  group node["jenkins"]["server"]["group"]
end

directory "#{node['jenkins']['server']['home']}/plugins" do
  owner node["jenkins"]["server"]["user"]
  group node["jenkins"]["server"]["group"]
  only_if { node["jenkins"]["server"]["plugins"].size > 0 }
end

node["jenkins"]["server"]["plugins"].each do |name|
  remote_file "#{node['jenkins']['server']['home']}/plugins/#{name}.jpi" do
    source "http://mirrors.jenkins-ci.org/plugins/#{name}/latest/#{name}.hpi"
    backup false
    owner node["jenkins"]["server"]["user"]
    group node["jenkins"]["server"]["group"]
    action :create_if_missing
  end
end

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

template "/etc/default/jenkins" do
  mode 00644
  owner "root"
  group "root"
end

service "jenkins" do
  action [:enable, :start]
end
