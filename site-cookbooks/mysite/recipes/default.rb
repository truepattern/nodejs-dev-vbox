include_recipe "nginx"

template "mysite" do
  path "#{node['nginx']['dir']}/sites-available/mysite"
  source "nginx/mysite.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, resources(:service => "nginx")
end

nginx_site "mysite"

