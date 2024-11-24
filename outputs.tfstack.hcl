output "security_scanner_arn" {
  description = "ARNs for the security scanner"
  type  = list(string)
  value = [ for x in component.iam_role: x.security_scanner ]
}

output "finops_scanner_arn" {
  description = "ARNs for the finops scanner"
  type  = list(string)
  value = [ for x in component.iam_role: x.finops_scanner ]
}