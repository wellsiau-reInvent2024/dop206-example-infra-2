# Deploy IAM role for each account in the var.accounts
component "iam_role" {
  for_each = var.accounts

  source = "./iam-role"

  inputs = {
    enable_security_scanner = var.enable_security_scanner
    enable_finops_scanner   = var.enable_finops_scanner
  }

  providers = {
    aws    = provider.aws.configurations[each.value]
    random = provider.random.this
  }
}