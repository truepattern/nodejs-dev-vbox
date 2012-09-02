cookbook_file "/etc/init/mysite-nodejs.conf" do
    source "nodejs.conf"
    owner "root"
    group "root"
    mode 0644
end

service "mysite-nodejs" do
    provider Chef::Provider::Service::Upstart
    enabled true
    running true
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

