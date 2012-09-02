name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[users::sysadmins]",
  "recipe[sudo]",
  "recipe[apt]",
  "recipe[git]",
  "recipe[build-essential]",
  "recipe[vim]"
) 
override_attributes(
  :authorization => {
    :sudo => {
      :groups => ["sysadmin"],
      :users => ["ubuntu", "vagrant"],
      :passwordless => true
    }
  }
)

