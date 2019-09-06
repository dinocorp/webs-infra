require 'netaddr'

namespace :network do
  desc "Outputs public and private subnets for a VPC"
  task :subnet, [:vpc_subnet, :cidr_prefix, :az_count] do |t, args|

    vpc_cidr = NetAddr::IPv4Net.parse(args.vpc_subnet)

    @public_subnets = []
    @private_subnets = []

    0.upto(vpc_cidr.subnet_count(args.cidr_prefix.to_i) - 1) do |i|
      subnet = vpc_cidr.nth_subnet(args.cidr_prefix.to_i,i)
      i.even? ? @public_subnets << subnet.to_s : @private_subnets << subnet.to_s
    end
    puts ""
    puts "  vpc_subnet = \"#{args.vpc_subnet}\""
    puts "  public_subnets = #{@public_subnets[0 ... args.az_count.to_i]}"
    puts "  private_subnets = #{@private_subnets[0 ... args.az_count.to_i]}"
  end
end
