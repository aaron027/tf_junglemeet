# SSL Certificate
resource "aws_acm_certificate" "ssl_certificate_www" {
  provider                  = aws.acm_provider
  domain_name               = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  #   validation_method = "EMAIL"
  validation_method = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "ssl_certificate_root" {
  provider                  = aws.acm_provider
  domain_name               = var.domain_name
  subject_alternative_names = ["${var.domain_name}"]
  #   validation_method = "EMAIL"
  validation_method = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

# Uncomment the validation_record_fqdns line if you do DNS validation instead of Email.
resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.ssl_certificate_root.arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}

resource "aws_acm_certificate_validation" "cert_validation_www" {
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.ssl_certificate_www.arn
  validation_record_fqdns = [for record in aws_route53_record.subdomain : record.fqdn]
}