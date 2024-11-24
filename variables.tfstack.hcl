# List of target accounts
variable "accounts" {
  description = "list of accounts as target for deployment"
  type = set(string)
}

# Target Role name for AWS provider
variable "role_name" {
  description = "Role ARN that Stack will assume"
  type = string
}

# Target region for AWS provider
variable "region" {
  type = string
}

# JWT identity token for AWS provider
variable "identity_token" {
  type      = string
  ephemeral = true
}

# Default tags
variable "default_tags" {
  description = "A map of default tags to apply to all AWS resources"
  type        = map(string)
  default     = {}
}

# Set to true if you want to deploy the example IAM role
variable "enable_security_scanner" {
  type    = bool
  default = true
}

# Set to true if you want to deploy the example IAM role
variable "enable_finops_scanner" {
  type    = bool
  default = true
}