default['develop-env']['git']['user.name'] = ""
default['develop-env']['git']['user.email'] = ""

default['develop-env']['grunt-cli']['version']	= "0.1.9"
default['develop-env']['typescript']['version']	= "0.9.1"


include_attribute "nodejs"
include_attribute "npm"

# レシピで更新した分は他に影響を及ぼさないって書いてあった
# http://www.engineyard.co.jp/blog/2013/breaking_changes_chef_11/
node.override['nodejs']['src_url'] = "http://nodejs.org/dist" # 何故か指定しないと上手く動かない気がする？？？
node.override['nodejs']['install_method'] = "binary"
node.override['nodejs']['version'] = "0.10.15"
node.override['nodejs']['checksum_linux_x64'] = "0b5191748a91b1c49947fef6b143f3e5e5633c9381a31aaa467e7c80efafb6e9"

node.override['npm']['version'] = "1.3.7"
