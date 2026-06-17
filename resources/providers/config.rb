# Cookbook:: rb_net_tools
# Provider:: config

action :add do
  begin
    cdomain     = new_resource.cdomain
    sensor_uuid = new_resource.sensor_uuid
    rb_webui    = new_resource.rb_webui

    dnf_package 'redborder-net-tools' do
      action :install
    end

    template '/etc/sysconfig/redborder-net-tools' do
      source 'redborder-net-tools_sv.erb'
      owner 'root'
      group 'root'
      mode '0640'
      retries 2
      cookbook 'rb_net_tools'
      variables(
        rb_webui:    rb_webui,
        cdomain:     cdomain,
        sensor_uuid: sensor_uuid
      )
      notifies :restart, 'service[redborder-net-tools]', :delayed
    end

    service 'redborder-net-tools' do
      service_name 'redborder-net-tools'
      ignore_failure true
      supports status: true, restart: true, enable: true
      action [:start, :enable]
    end

    Chef::Log.info('redborder-net-tools has been configured correctly.')
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin
    service 'redborder-net-tools' do
      ignore_failure true
      supports status: true, enable: true
      action [:stop, :disable]
    end

    file '/etc/sysconfig/redborder-net-tools' do
      action :delete
    end

    dnf_package 'redborder-net-tools' do
      action :remove
    end

    Chef::Log.info('redborder-net-tools has been removed correctly.')
  rescue => e
    Chef::Log.error(e.message)
  end
end
