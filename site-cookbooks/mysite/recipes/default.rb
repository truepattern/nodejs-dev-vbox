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

#nginx_site "mysite" do
  #template "nginx/mysite.conf.erb"
  #action :enable
#end

#
#directory "/var/www/construction" do
  #owner "www-data"
  #group "sdmin"
  #mode "0755"
#end

