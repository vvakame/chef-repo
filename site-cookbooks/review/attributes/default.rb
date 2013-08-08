include_attribute "texlive2013"
include_attribute "jenkins"

# too heavy on platform_family eq rhel
default['review']['pdf'] = false

# add jenkins tasks
default['review']['jenkins']['sample'] = false
default['review']['jenkins']['job']['name'] = "ReVIEW-sample-book"
default['review']['jenkins']['job']['git']['repository'] = "https://github.com/takahashim/review-sample-book.git"
default['review']['jenkins']['job']['git']['branch'] = "**"
default['review']['jenkins']['job']['git']['trigger_spec'] = "H/5 * * * *"
default['review']['jenkins']['job']['src_folder'] = "./src"
default['review']['jenkins']['job']['result_exclude'] = "src/book/"
