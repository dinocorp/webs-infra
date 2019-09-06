# The Actual README

Firstly, this is way more than was required... It does create a few instances in
an ASG behind an ELB, an Aurora DB, related security groups and infrastructure
like VPC's, Subnets, Nat Gateway(s). But that's all rather boring. It's intended
to be something to stimulate discussion, ideas and understandings both ways.

This is probably going to be a little different from what goes on at the moment
and **probably won't make sense without some active discussion.** As that
doesn't look like it's happening anytime soon I'll try to add as much context as
possible in this README.

**As with any example where technology is concerned try to grasp an understanding
of the concept or idea around something rather than the concrete example.**

*Some of the tools I'm applying I haven't used before but here they solve
various problems. They might just add complexity... I'll let you know.*

*I've used Terraform 0.12 here... There are a few differences in syntax and
strictness, one of the biggest been that variable references are now a first
class citizen in Terraform. There's no need for `${var.something}`, if that's
all you need to pass you can simply use `var.something`.*  

The AWS environments will also look a bit different as they're in a single
account: `<<THIS_ORG>>-mgt-sandbox` in reality you'd want to split your `prod` and
`nonprod` environments across separate accounts to reduce _blast radius_.

Because we want to do things quickly and not repeat ourselves I'll mostly make
use of upstream terraform modules. I _might_ write a local module more specific
to my needs or to apply required standards (tags etc...)

## Concepts
### DevEx
Or rather, Platform Development Experience. As a Platform Engineer I want how I
interact with my infrastructure to be simple, repeatable and consistent.

The same tools and commands I could use locally should probably be the same tools and
commands that are used on my CI server.

In this case I've written some rake tasks to help with tasks like formatting or
validating code or planning and applying terraform changes. I want these tasks to
have some level of safety built-in such as ensuring I don't destroy production
environments or run something on the wrong account by mistake.

### Consistency
It's good to have consistency across product infrastructures. All too often things
like terraform s3 backend state keys or tag standards are manually implemented
by engineers. There are tools and practices out there to help:

- `terragrunt` - Actually very good at programmatically specifying backend buckets,
  paths and input variables.

- `README.md` - The README file in this repository is generated using a rake task
  `rake docs:readme`. The file is templated and takes created from various config
  input in the `product.yaml` file. Now, as an engineer I know that I can glance
  at a products infrastructure repo and see who it's contacts are or what it's
  core operating times are.

- `Network Subnets` - Once you've assigned or found a suitable VPC subnet (should probably
  be different from your on-prem networks and other product VPC subnets). It's
  time to slice it up and assign subnets to your public and private subnets in each AZ.
  Even this should probably be consistent so that an IP address can give context
  (what product? what public or private? what AZ?). Scripting this and using
  programatically can enforce any standards. Example:
  ```
  $ rake network:subnet[172.20.0.0/16,24,3]

    vpc_subnet = "172.20.0.0/16"
    public_subnets = ["172.20.0.0/24", "172.20.2.0/24", "172.20.4.0/24"]
    private_subnets = ["172.20.1.0/24", "172.20.3.0/24", "172.20.5.0/24"]
  ```

I'm a fan of code generators and templating for consistency and generation of
new things.

### Modules
Terraform modules are widely used. I think there's a few different module "types"
I don't think there's any naming conventions for the different types of module... yet...:

- `core or base modules` - These are generic low-level modules such as upstream
AWS community modules. They usually focus on doing one thing, using a handful of
Terraform resources. They usually live in a repository or registry of some sort.

- `lookup or data modules` - These are modules that have variables and outputs.
  For example, I've created a module that returns the price of an instance by instance
  type (ec2_spot_prices). This allows to set the spot_price on modules by enabling
  spots with a boolean (instance_spots) and referencng the module output like:
  ```
    module "ec2_spot" {
      source        = "../ec2_spot_prices"
      instance_type = var.instance_spots ? var.instance_type : ""
    }

    ...
      spot_price = module.ec2_spot.price
    ...
  ```
  Now when new instance types are added to AWS EC2 we only need to update the
  `ec2_spot` module. This sort of module can be used to validate or audit various
  things like limiting the instance types your organisation can use.

- `service or proxy modules` - These are modules that your organisation usually
  creates, they make use of multiple modules to achieve something like an ASG behind
  an ELB. They ensure and enforce organisational standards such as tagging resources
  or applying ACLs. They usually reside in your orgs repository and are subject to
  testing and versioning.

- `local modules` - Specific to your product or application, they might be new
  service modules that aren't fully production ready that will be promoted for use
  by the rest of the organisation soon. They should be used sparingly and it's a
  code smell if products have many, many local modules which suggests that the
  platform engineer is either unaware of the organisations modules or the modules
  are missing key functionality.

Terraform modules should be versioned, this brings about the problem of how to
manage those versions and modules in your infrastructure code. Setting a `ref` in
your module declaration source will lead to dependency management hell, multiple
versions and painful upgrade paths lay ahead. Git submodules _could_ be used but
they pin to a commit and there's little in the way of context... What version is
`6f554751166c792b7020f5fa52c845fda770d0e4` and how do I make use of a module that
isn't in git?

The `xterrafile` brings a `librarian-puppet` like experience to Terraform modules.
The `Terrafile` originated back at ITV with a friend of mine (Ben):
http://bensnape.com/2016/01/14/terraform-design-patterns-the-terrafile/. I expanded
on this and released `xterrafile` that is used by a few people and orgs to manage
Terraform modules and even things like Saltstack formulas.

## Tooling

Tooling is key to a good PE development experience. Anything that makes it easy
to consistently interact with your infrastructure is useful.

### TFEnv

`tfenv` allows us to use different Terraform versions across multiple projects.

#### Installation

```
brew install tfenv
```
#### Further Reading

https://github.com/tfutils/tfenv

### Terragrunt

`terragrunt` is a wrapper around `terraform` with some extra features to help
maintain a consistent codebase.

#### Installation

```
# Ignore terraform dependency
brew install terragrunt --ignore-dependencies
```

#### Further Reading

https://github.com/gruntwork-io/terragrunt

### XTerrafile

`xterrafile` is a tool to help you manage and "vendor" Terraform modules.

#### Installation

```
brew tap devopsmakers/xterrafile && brew install xterrafile
```

#### Further Reading

https://github.com/devopsmakers/xterrafile
