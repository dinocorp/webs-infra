require 'yaml'
require_relative 'lib/config'

# We retrieve configuration to a constant to reference
# CONFIG throughout other tasks
CONFIG = get_config(YAML.load_file("./product.yaml"))

# All tasks are namespaced in the lib folder, they could be moved out to gem
# packages for sharing across products
Dir.glob('lib/tasks/*.rake').each { |r| load r}
