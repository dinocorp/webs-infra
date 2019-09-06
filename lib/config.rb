# Returns full config for injection into rake tasks
def get_config(config)
  # Build a list of valid environments
  config["valid_envs"] = []

  # Anything to be applied to ecosystems / environments
  config["accounts"].each do |ecosystem, data|
    config["accounts"][ecosystem]["alias"] = "#{config["organization"]}-#{config["product"]}-#{ecosystem}"
    data["environments"].each do |envname, envconfig|
      config["valid_envs"] << envname
    end
  end

  return config
end
