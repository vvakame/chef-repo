name "review-jenkins"
description "jenkins server for ReVIEW"

run_list "recipe[npm]", "recipe[develop-env]", "recipe[review]", "role[jenkins]"
