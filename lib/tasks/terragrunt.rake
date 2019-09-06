require 'aws-sdk'

namespace :terragrunt do

  desc "Installs modules declared in Terrafile"
  task :modules do
    Dir.chdir("terraform") do
      sh("xterrafile install")
    end
  end

  desc "Clean an environments terraform cache"
  task :clean, [:environment] do |t, args|
    @ecosystem = get_ecosystem(args.environment)
    Dir.chdir("terraform/#{@ecosystem}/#{args.environment}") do
      @cache_dirs = Dir.glob("**/.terraform").select { |fn| File.directory?(fn) }
      unless @cache_dirs.empty?
        rm_rf @cache_dirs
      end
      puts "Caches are clean..."
    end
  end

  desc "Initialise an environment with terragrunt"
  task :init, [:environment] do |t, args|
    terragrunt_run(args.environment, "init")
  end

  desc "Validate an environments terraform code with terragrunt"
  task :validate, [:environment] do |t, args|
    terragrunt_run(args.environment, "validate")
  end

  desc "Run a plan-all against an environments terraform code with terragrunt"
  task :plan, [:environment] do |t, args|
    terragrunt_run(args.environment, "plan")
  end

  desc "Run an apply-all against an environments terraform code with terragrunt"
  task :apply, [:environment] do |t, args|
    terragrunt_run(args.environment, "apply")
  end

  desc "Run an destroy-all against an environments terraform code with terragrunt"
  task :destroy, [:environment] do |t, args|
    @ecosystem = get_ecosystem(args.environment)
    if ["prod", "prd"].include? @ecosystem
      STDERR.puts "You can't run destroy all agains a production environment"
      exit 1
    end
    terragrunt_run(args.environment, "destroy")
  end

  desc "Format all terraform and terragrunt code"
  task :fmt, [:environment] do |t, args|
    @tg_dirs = Dir.glob("**/#{args.environment}/**/terragrunt.hcl").map{ |fn| File.dirname(fn) }.compact

    puts "Formatting Terragrunt..."
    @tg_dirs.each do |tgd|
      Dir.chdir(tgd) do
        sh("terragrunt hclfmt")
      end
    end
  end

  def terragrunt_run(environment, action)
    @ecosystem = get_ecosystem(environment)
    Dir.chdir("terraform/#{@ecosystem}/#{environment}") do
      environment.include?("/") ? (sh("terragrunt #{action}")) : (sh("terragrunt #{action}-all"))
    end
  end

  def get_ecosystem(environment)
    @env = environment.split("/")[0]
    if environment.nil? || ! CONFIG["valid_envs"].include?(@env)
       STDERR.puts "A valid environment argument must be supplied"
       exit 1
    end
    @ecosystem = CONFIG["accounts"].select{|k, h| h["environments"].key?(@env)}.keys[0]

    if @ecosystem.nil? || @ecosystem.empty?
       STDERR.puts "Ecosystem can not be empty"
       exit 1
    end

    validate_account(@ecosystem)

    return @ecosystem
  end

  def validate_account(ecosystem)
    begin
      @aws_caller_account_id = Aws::STS::Client.new().get_caller_identity()["account"]
      @aws_caller_account_alias = Aws::IAM::Client.new().list_account_aliases["account_aliases"][0]
    rescue StandardError => e
      STDERR.puts "Error: #{e.inspect}"
      STDERR.puts "Please assume the desired role for this action."
      exit 1
    end
    @ecosystem_account_id = CONFIG["accounts"][ecosystem]["id"]
    @ecosystem_account_alias = CONFIG["accounts"][ecosystem]["alias"]

    if @aws_caller_account_id != @ecosystem_account_id || @aws_caller_account_id != @ecosystem_account_alias
       STDERR.puts "Error! You're running against an incorrect account ID or alias."
       STDERR.puts "  * Caller Account (#{@aws_caller_account_alias}) ID: #{@aws_caller_account_id}"
       STDERR.puts "  * Expected Account (#{@ecosystem_account_alias}) ID: #{@ecosystem_account_id}"
       STDERR.puts "Please assume the correct role for this account."
       exit 1
    end
  end

end
