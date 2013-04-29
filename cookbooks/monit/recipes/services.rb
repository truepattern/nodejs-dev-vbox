include_recipe "monit::default"

# 
# Pulls the appropriate configs from the "monit" data bag.
# These should be specified in a role.
#

node['monit']['services'].each do |item_name|
  search(:monit, "id:#{item_name}") do |services|

    services.each do |service, service_config|
        
      # Don't use the monitrc definition. Instead,
      # just write a new template.
      if service != "id"        
        template "/etc/monit/conf.d/#{service}.conf" do 
          owner "root"
          group "root"
          mode 0644
          source "services.conf.erb"
          variables( 
            "service" => service,
            "conf" => service_config
          )
          notifies :restart, resources(:service => "monit"), :delayed
          action :create
        end
      end
    end
  end
end
