#
# Cookbook Name:: texlive2013
# Recipe:: default
#
# Copyright 2013, vvakame
#
# All rights reserved - Do Not Redistribute
#

# tlmgr が存在していれば既にインストール済みでいいと思うなー
if ::File.exist?("/usr/local/texlive/2013/bin/x86_64-linux/tlmgr")
	Chef::Log.info('texlive2013 already installed.')
else
	# wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
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

	# tar -zxvf install-tl-unx.tar.gz
	# ./install-tl --profile=installation.profile
	bash "install texlive2013" do
		cwd Chef::Config['file_cache_path']
		retries 5
		code <<-EOH
		tar zxvf install-tl-unx.tar.gz
		cd install-tl-*
		./install-tl --profile=#{Chef::Config['file_cache_path']}/texlive.profile
		EOH
	end

	# PATHの設定
	template "/etc/profile.d/texlive.sh" do
		source 'texlive.sh.erb'
		owner "root"
		mode 00755
	end
end
