#
# Cookbook Name:: review
# Recipe:: default
#
# Copyright 2013, vvakame
#
# MIT license
#

# testing on only CentOS 6.4

# for platex
if node['review']['pdf']
	case node['platform_family']
	when "rhel"
		include_recipe "texlive2013"

	when "debian"
		# not tested
		# https://text-n.appspot.com/#/html/aghzfnRleHQtbnIMCxIEVGV4dBiZ4wYM
		# texlive-lang-cjk が デフォであるのUbuntuだけっぽい
		# Debianも7系からはあるらしい
		apt_package "texlive-lang-cjk" do
			action :install
		end
	end
end

# for review
gem_package "review" do
	action :install
end

# for review-epubmaker
package "zip" do
	action :install
end

# jenkins job setup
if node['review']['jenkins']['sample']

	job_name = "#{node['review']['jenkins']['job']['name']}"
	git_repository = "#{node['review']['jenkins']['job']['git']['repository']}"
	git_branch = "#{node['review']['jenkins']['job']['git']['branch']}"
	git_trigger_spec = "#{node['review']['jenkins']['job']['git']['trigger_spec']}"
	src_folder = "#{node['review']['jenkins']['job']['src_folder']}"
	result_exclude = "#{node['review']['jenkins']['job']['result_exclude']}"

	job_config = File.join(node['jenkins']['server']['home'], "#{job_name}-config.xml")

	jenkins_job job_name do
		action :nothing
		config job_config
	end

	template job_config do
		source "jenkins-config-review.xml.erb"
		owner node['jenkins']['server']['group']
		group node['jenkins']['server']['user']
		mode 00644
		variables(
			:git_repository => git_repository,
			:git_branch => git_branch,
			:trigger_spec => git_trigger_spec,
			:src_folder => src_folder,
			:result_exclude => result_exclude,
			:job_name => job_name
		)
		notifies :update, resources(:jenkins_job => job_name), :immediately
		notifies :build, resources(:jenkins_job => job_name), :immediately
		not_if do
			File.exists?(job_config)
		end
	end
end
