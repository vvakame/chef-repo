#
# Cookbook Name:: texlive2013
# Recipe:: default
#
# Copyright 2013, vvakame
#
# MIT license
#

# tlmgr が存在していれば既にインストール済みでいいと思うなー
arch = "x86_64" # TODO install-tl のこの部分の取得ロジックがよくわからない…
unless node['kernel']['machine'] =~ /x86_64/
	Chef::Application.fatal!("Unknown platform type #{kernel['machine']}!")
end
bin_path = "#{node['texlive2013']['texdir']}/bin/#{arch}-linux"

if ::File.exist?("#{bin_path}/tlmgr")
	Chef::Log.info('texlive2013 already installed.')
else
	# wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
	src_filepath = "#{Chef::Config['file_cache_path']}/install-tl-unx.tar.gz"
	repository = node['texlive2013']['repository']

	remote_file "install-tl-unx.tar.gz" do
		# source "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
		source "#{repository}/install-tl-unx.tar.gz"
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
			:texdir => node['texlive2013']['texdir']
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
		./install-tl --profile=#{Chef::Config['file_cache_path']}/texlive.profile -repository #{repository}
		EOH
	end

	# PATHの設定
	template "/etc/profile.d/texlive.sh" do
		source 'texlive.sh.erb'
		owner "root"
		variables(
			:bin_path => bin_path
		)
		mode 00755
	end
end
