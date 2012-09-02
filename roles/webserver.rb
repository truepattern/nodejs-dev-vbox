name "webserver"
description "Web server role"
all_env = [ 
  "role[base]",
  "recipe[nginx::default]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env, 
  "prod" => all_env,
  #"prod" => all_env + ["recipe[nginx::http_geoip_module]"],
  "dev" => all_env
)

