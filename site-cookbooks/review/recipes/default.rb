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

include_recipe "yum::epel"

# for platex
yum_package "texlive-latex" do
	action :install
end

yum_package "texlive-east-asian" do
	action :install
end

yum_package "xdvik" do
	action :install
end

yum_package "dvipdfmx" do
	action :install
end

yum_package "ipa-mincho-fonts" do
	action :install
end

yum_package "ipa-gothic-fonts" do
	action :install
end

# for review
gem_package "review" do
	action :install
end
