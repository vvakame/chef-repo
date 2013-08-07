#
# Cookbook Name:: develop-env
# Recipe:: default
#
# Copyright 2013, vvakame
#
# All rights reserved - Do Not Redistribute
#

package "git"

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
