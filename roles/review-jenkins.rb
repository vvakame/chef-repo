name "review-jenkins"
description "jenkins server for ReVIEW"

run_list "recipe[npm]", "role[jenkins]", "recipe[develop-env]", "recipe[review]"
