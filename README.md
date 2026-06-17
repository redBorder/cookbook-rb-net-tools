# cookbook-rb-net-tools

Chef cookbook that installs and configures the `rb-net-tools` daemon on redborder proxy nodes.

## Usage

Called from `cookbook-rb-proxy` via:

```ruby
rb_net_tools_config 'Configure rb-net-tools' do
  cdomain     node['redborder']['cdomain']
  sensor_uuid node['redborder']['sensor_uuid']
  action :add   # or :remove
end
```

## License

AFFERO GENERAL PUBLIC LICENSE, Version 3
