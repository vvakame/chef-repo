name "review-jenkins"
description "jenkins server for ReVIEW"

# メモ recipe[review]でのJenkinsのReVIEWタスク投入にgitが必要 gitはrecipe[develop-env]でインストールされる
run_list "role[jenkins]", "recipe[npm]", "recipe[develop-env]", "recipe[review]"
