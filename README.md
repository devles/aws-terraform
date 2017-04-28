# aws-terraform
application/ contains the following files:

00-provider.tf: The aws provider block. The variables 'access_key' and 'secret_key' must be set.
01-vpc.tf: Creates a VPC, public subnet, internet and NAT gateways
02-subnets.tf: Creates private subnets, route tables and security group
03-alb.tf: Creates an Application Load Balancer with an http listener that forwards to a target group
04-route53.tf: Creates a route53 A type record set for test or prod environment 