# HCP Terraform uses this to assume the role in the target account
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  iam_role = {
    region = "us-east-1"
  }
}

store "varset" "accounts" {
  id       = "varset-rbeeCsRRRPWN5SQU" #stacks_infra2_ou
  category = "env"
}

deployment "dev_ou" {
  inputs = {
    region         = local.iam_role.region
    accounts       = jsondecode(store.varset.accounts.dev)
    identity_token = identity_token.aws.jwt
    role_name      = "HCPTerraform-Role-StackSet"
    default_tags   = { stacks-preview-example = "dop206-example-infra-1-new" }
    enable_security_scanner = true
    enable_finops_scanner   = false
  }
}

deployment "prod_ou" {
  inputs = {
    region         = local.iam_role.region
    accounts       = jsondecode(store.varset.accounts.prod)
    identity_token = identity_token.aws.jwt
    role_name      = "HCPTerraform-Role-StackSet"
    default_tags   = { stacks-preview-example = "dop206-example-infra-1-new" }
    enable_security_scanner = true
    enable_finops_scanner   = true
  }
}

# orchestrate "auto_approve" "core_ou" {
#     check {
#         condition = context.plan.deployment == deployment.core_ou
#         reason = "Auto-approve every accounts in Core OU"
#     }
# }
