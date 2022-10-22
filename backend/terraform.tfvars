name                = "junglemeet"
environment         = "dev"
availability_zones  = ["us-east-1a", "us-east-1b"]
private_subnets     = ["10.0.0.0/20", "10.0.32.0/20"]
public_subnets      = ["10.0.16.0/20", "10.0.48.0/20"]
tsl_certificate_arn = "mycertificatearn"
container_memory    = 1024
container_image     = "026376606405.dkr.ecr.us-east-1.amazonaws.com/myapp"
