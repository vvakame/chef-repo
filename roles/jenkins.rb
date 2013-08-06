name "jenkins"
description "jenkins server"

run_list "recipe[iptables]", "recipe[java]", "recipe[jenkins::server]", "recipe[jenkins::iptables]"

override_attributes "java" => {
	"install_flavor" => "oracle",
	"jdk_version" => "7",
	"oracle" => {
		"accept_oracle_download_terms" => true
	}
}

override_attributes "jenkins" => {
	"iptables_allow" => "enable",
	"server" => {
		"plugins" => [
			"git"
		]
	}
}
