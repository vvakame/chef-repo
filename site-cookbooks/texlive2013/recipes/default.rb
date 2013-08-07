#
# Cookbook Name:: texlive2013
# Recipe:: default
#
# Copyright 2013, vvakame
#
# All rights reserved - Do Not Redistribute
#

# TODO 既にダウンロード済みの場合落とし直すのやめたほうが良いと思う

# wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
# tar -zxvf install-tl-unx.tar.gz
src_filepath = "#{Chef::Config['file_cache_path']}/install-tl-unx.tar.gz"
remote_file "install-tl-unx.tar.gz" do
	# source "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
	source "http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz"
	# checksum "" # TODO
	mode 00644
	path src_filepath
	backup false
end

# create profile
template "#{Chef::Config['file_cache_path']}/texlive.profile" do
	source 'texlive.profile.erb'
	mode 00644
	variables(
	)
end

# omit
# rm -rf /usr/local/texlive/2013
# rm -rf ~/.texlive2013

# ./install-tl --profile=installation.profile
bash "install texlive2013" do
	cwd Chef::Config['file_cache_path']
	code <<-EOH
	tar zxvf install-tl-unx.tar.gz
	cd install-tl-*
	./install-tl --profile=#{Chef::Config['file_cache_path']}/texlive.profile
	EOH
end
