# application
application/ contains the following files:

00-provider.tf: The aws provider block. The variables 'access_key' and 'secret_key' must be set.

01-vpc.tf: Creates a VPC, public subnet, internet and NAT gateways.

02-subnets.tf: Creates private subnets, route tables and security group.

03-alb.tf: Creates an Application Load Balancer with an http listener that forwards to a target group.

04-route53.tf: Creates a route53 A type record set for test or prod environment.

outputs.tf: Example output

variables.tf: Declares variables used in the environment build

terraform.ftvars: Global variables for the VPC

test-env.ftvars: Variables for the test environment

## To Build the 'test' environment

$terraform apply -var-file=test-env.tfvars

You can also build just the resources in each file with the following commands:

01-vpc.tf: terraform apply -var-file=test-env.tfvars -target=aws_nat_gateway.nat_gw

02-subnets.tf: terraform apply -var-file=test-env.tfvars -target=aws_security_group.private_sg0

03-alb.tf: terraform apply -var-file=test-env.tfvars -target=aws_alb_listener_rule.app_alb_listener_rule

# bastion
Builds a bastion server in a VPC

Files:

00-provider.tf: The aws provider block. The variables 'access_key' and 'secret_key' must be set.

01-bastion.tf: Creates the bastion server

variables.tf: Variables are declared and some have default values.  vpc_id and public_subnet have to be supplied.

## To build a bastion server

$ terraform apply 01-bastion.tf -var='vpc_id=<id of vpc>' -var='public_subnet=<public subnet id'

eg: terraform apply 01-bastion.tf -var='vpc_id=vpc-2cff274a' -var='public_subnet=subnet-8571efa8'