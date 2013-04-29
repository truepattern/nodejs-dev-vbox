name "monit"
description "Monit role"
all_env = [ 
  "recipe[monit::default]",
  "recipe[monit::services]"
]

default_attributes(
  "monit" => {
    "services" => ["monit_services"]
  }
)

run_list(all_env)

env_run_lists(
  "_default" => all_env, 
  "prod" => all_env,
  "dev" => all_env
)

