name "jenkins"
description "jenkins server"

run_list "recipe[iptables]", "recipe[jenkins::server]", "recipe[jenkins::iptables]"

override_attributes "jenkins" => {
	"iptables_allow" => "enable",
	"server" => {
		"plugins" => [
			"credentials", "ssh-credentials", "git-client", "git" # git and git dependencies
		]
	}
}
