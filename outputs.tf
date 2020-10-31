output certificate_id {
  description = "The ID of the certificate"
  value       = aws_acm_certificate.default.id
}

output certificate_arn {
  description = "The ARN of the certificate"
  value       = aws_acm_certificate.default.arn
}
