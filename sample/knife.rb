log_level                :info
log_location             STDOUT
node_name                'vvakame'

base_dir = File.expand_path("~")
chef_repo = "#{base_dir}/Dropbox/chef-repo"

client_key               "#{base_dir}/.chef/vvakame.pem"
validation_client_name   'chef-validator'
validation_key           '/etc/chef-server/chef-validator.pem'
chef_server_url          'https://joachim.local:443'
syntax_check_cache_path  "#{base_dir}/.chef/syntax_check_cache"

cookbook_path	[
	"#{chef_repo}/cookbooks",
	"#{chef_repo}/site-cookbooks"
]
role_path		"#{chef_repo}/roles"
