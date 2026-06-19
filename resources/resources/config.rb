# Cookbook:: rb_net_tools
# Resource:: config
actions :add, :remove
default_action :add

attribute :cdomain,     kind_of: String, default: 'redborder.cluster'
attribute :sensor_uuid, kind_of: String, default: ''
attribute :rb_webui,    kind_of: String, default: 'webui'
attribute :user,        kind_of: String, default: 'redborder-net-tools'