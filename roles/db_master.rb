name "db_master"
description "Master database server"

all_env = [
  "role[base]", 
  #"recipe[mysql::server]"
  "recipe[mongodb::10gen_repo]",
  "recipe[mongodb::default]"
] 

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  "dev" => all_env
)

