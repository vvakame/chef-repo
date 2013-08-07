log_level                :info
log_location             STDOUT
node_name                'vvakame'

base_dir = "/Users/vvakame"

client_key               "#{base_dir}/.chef/vvakame.pem"
validation_client_name   'chef-validator'
validation_key           '/etc/chef-server/chef-validator.pem'
chef_server_url          'https://joachim.local:443'
syntax_check_cache_path  "#{base_dir}/.chef/syntax_check_cache"

cookbook_path	[
	"#{base_dir}/Dropbox/chef-repo/cookbooks",
	"#{base_dir}/Dropbox/chef-repo/site-cookbooks"
]
role_path		"#{base_dir}/Dropbox/chef-repo/roles"
