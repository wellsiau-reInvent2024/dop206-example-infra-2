# HCP Terraform uses this to assume the role in the target account
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  iam_role = {
    region = "us-east-1"
  }
  ou = {
    core = [
      "012345678901",
      "012345678910",
      "012345678911"
      ],
    prod = [
      "112345678901",
      "212345678910",
      "312345678911"
    ]
  }
}

# deployment "core_ou" {
#   inputs = {
#     region         = local.iam_role.region
#     accounts       = local.ou.core
#     identity_token = identity_token.aws.jwt
#     role_name      = "HCPTerraform-Role-StackSet"
#     default_tags   = { stacks-preview-example = "example1-infrastructure-ou" }
#     enable_security_scanner = true
#     enable_finops_scanner   = true
#   }
# }

# deployment "prod_ou" {
#   inputs = {
#     region         = local.iam_role.region
#     accounts       = local.ou.prod
#     identity_token = identity_token.aws.jwt
#     role_name      = "HCPTerraform-Role-StackSet"
#     default_tags   = { stacks-preview-example = "example1-infrastructure-ou" }
#     enable_security_scanner = true
#     enable_finops_scanner   = false
#   }
# }

# orchestrate "auto_approve" "core_ou" {
#     check {
#         condition = context.plan.deployment == deployment.core_ou
#         reason = "Auto-approve every accounts in Core OU"
#     }
# }