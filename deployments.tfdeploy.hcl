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
      "589140316372",
      "031374037584",
      "830830285209"
      ],
    prod = [
      "197831068840",
      "620992073655",
      "927911426753",
      # "887703211062"
    ]
  }
}

deployment "core_ou" {
  inputs = {
    region         = local.iam_role.region
    accounts       = local.ou.core
    identity_token = identity_token.aws.jwt
    role_name      = "HCPTerraform-Role-StackSet"
    default_tags   = { stacks-preview-example = "dop206-example-infra-1-new" }
    enable_security_scanner = true
    enable_finops_scanner   = true
  }
}

deployment "core_prod" {
  inputs = {
    region         = local.iam_role.region
    accounts       = local.ou.prod
    identity_token = identity_token.aws.jwt
    role_name      = "HCPTerraform-Role-StackSet"
    default_tags   = { stacks-preview-example = "dop206-example-infra-1-new" }
    enable_security_scanner = true
    enable_finops_scanner   = false
  }
}

# orchestrate "auto_approve" "core_ou" {
#     check {
#         condition = context.plan.deployment == deployment.core_ou
#         reason = "Auto-approve every accounts in Core OU"
#     }
# }