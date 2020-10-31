data aws_route53_zone default {
  name = var.domain_name
}

resource aws_acm_certificate default {
  domain_name               = var.is_wildcard ? "*.${var.domain_name}" : var.domain_name
  subject_alternative_names = var.is_wildcard ? [var.domain_name] : var.subject_alternative_names
  validation_method         = "DNS"

  tags = {
    Name = var.is_wildcard ? "${var.domain_name} wildcard" : var.domain_name
  }
}

locals {
  records_to_create         = var.is_wildcard ? 1 : length(var.subject_alternative_names) + 1
  domain_validation_options = aws_acm_certificate.default.domain_validation_options
}


/*
 * To understand conditionally omitted arguments, see
 *  https://www.hashicorp.com/blog/terraform-0-12-conditional-operator-improvements/
 *
 *
 * The `count`, `for_each` and `for` arguments do not render if the count is 0, or
 * the list is empty. To understand more about each, see
 * https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each/
 */

# creates a DNS record against each validation option
resource aws_route53_record default {
  count = local.records_to_create

  zone_id = data.aws_route53_zone.default.zone_id
  type    = lookup(local.domain_validation_options[count.index], "resource_record_type")
  name    = lookup(local.domain_validation_options[count.index], "resource_record_name")
  ttl     = 3600

  records = [
    lookup(local.domain_validation_options[count.index], "resource_record_value")
  ]

  depends_on = [
    aws_acm_certificate.default,
  ]
}

# this doesn't create record, but wait for the certificate validation process to finish
resource aws_acm_certificate_validation validations {
  certificate_arn         = aws_acm_certificate.default.arn
  validation_record_fqdns = aws_route53_record.default.*.fqdn

  depends_on = [
    aws_acm_certificate.default,
    aws_route53_record.default,
  ]
}
