#
# Cookbook Name:: develop-env
# Recipe:: default
#
# Copyright 2013, vvakame
#
# All rights reserved - Do Not Redistribute
#

# install git & setup
package "git"

if node['develop-env']['git']['user.name'] == ""
	Chef::Log.error("node['develop-env']['git']['user.name'] is required")
	raise "required node['develop-env']['git']['user.name']" # TODO 失敗させかたこれで正しいのか謎
end
if node['develop-env']['git']['user.email'] == ""
	Chef::Log.error("node['develop-env']['git']['user.email'] is required")
	raise "required node['develop-env']['git']['user.email']" # TODO 失敗させかたこれで正しいのか謎
end

template "#{node['jenkins']['server']['home']}/.gitconfig" do
	source '.gitconfig.erb'
	owner node['jenkins']['server']['group']
	group node['jenkins']['server']['user']
	mode 00644
	variables(
		:name  => node['develop-env']['git']['user.name'],
		:email => node['develop-env']['git']['user.email']
	)
end

# npm setup
def npm_missing?
	! run_context.loaded_recipe?("npm")
end

if npm_missing?
	Chef::Log.error("npm cookbook is missing. Please add to the run_list.")
	raise "required npm" # TODO 失敗させかたこれで正しいのか謎
end

npm_package "grunt-cli" do
	version "0.1.9"
	action :install
end 
