# aws-terraform
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