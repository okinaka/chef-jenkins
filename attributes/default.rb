default[:jenkins][:java_home] = ENV['JAVA_HOME']

default[:jenkins][:server][:home] = "/var/lib/jenkins"
default[:jenkins][:server][:user] = "jenkins"

case node[:platform]
when "debian", "ubuntu"
  default[:jenkins][:server][:group] = "nogroup"
else
  default[:jenkins][:server][:group] = node[:jenkins][:server][:user]
end

default[:jenkins][:server][:port] = 8080
default[:jenkins][:server][:host] = "127.0.0.1"
default[:jenkins][:server][:url]  = "http://#{node[:jenkins][:server][:host]}:#{node[:jenkins][:server][:port]}"

#download the latest version of plugins, bypassing update center
#example: ["git", "URLSCM", ...]
default[:jenkins][:server][:plugins] = []

#See Jenkins >> Nodes >> $name >> Configure

#"Remote FS root"
default[:jenkins][:node][:home] = "/home/jenkins"
