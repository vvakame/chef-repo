#
# Cookbook Name:: review
# Recipe:: default
#
# Copyright 2013, vvakame
#
# All rights reserved - Do Not Redistribute
#

# testing on only CentOS 6.4
# currently under testing

# for platex
if node['review']['pdf']
	case node['platform_family']
	when "rhel"
		include_recipe "texlive2013"

	when "debian"
		# not tested
		# https://text-n.appspot.com/#/html/aghzfnRleHQtbnIMCxIEVGV4dBiZ4wYM
		# texlive-lang-cjk が デフォであるのUbuntuだけっぽい
		apt_package "texlive-lang-cjk" do
			action :install
		end
	end
end

# for review
gem_package "review" do
	action :install
end
