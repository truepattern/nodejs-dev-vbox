package "monit"

if platform?("ubuntu")
  cookbook_file "/etc/default/monit" do
    source "monit.default"
    owner "root"
    group "root"
    mode 0644
  end
end

service "monit" do
  action [:enable, :start]
  enabled true
  supports [:start, :restart, :stop]
end

directory "/etc/monit/conf.d" do
  owner  'root'
  group 'root'
  mode 0755
  action :create
  recursive true
end

template "/etc/monit/monitrc" do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.erb'
  variables(
    :logfile          => node["monit"]["logfile"],
    :notify           => node["monit"]["notify"],
    :httpd            => node["monit"]["httpd"],
    :poll_period      => node["monit"]["poll_period"],
    :poll_start_delay => node["monit"]["poll_start_delay"],
    :mail             => node["monit"]["mail"],
    :queue            => node["monit"]["queue"],
    :config_directory => "/etc/monit/conf.d"
  )
  notifies :restart, resources(:service => "monit"), :delayed
end
