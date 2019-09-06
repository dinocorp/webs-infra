namespace :terraform do

  desc "Format all terraform code"
  task :fmt do
    @tf_dirs = Dir.glob("**/*.tf").map{ |fn| File.dirname(fn) if fn !~ /(vendor|.terraform)/ }.compact.uniq

    puts "Formatting Terraform..."
    @tf_dirs.each do |tfd|
      Dir.chdir(tfd) do
        sh("terraform fmt -diff")
      end
    end
  end

end
