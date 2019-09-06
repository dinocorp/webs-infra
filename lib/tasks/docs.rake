require "erb"

namespace :docs do
  desc "Re-generate the products README.md"
  task :readme do
    puts "Re-generating README.md..."
    erb = ERB.new(File.read("lib/templates/README.md.erb"))
    File.write('README.md', erb.result)
  end
end
