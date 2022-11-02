
data "aws_route53_zone" "public" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "jm_backend" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = "backend.${var.domain_name}"
  type    = "CNAME"
  ttl     = 60

  records = [
    var.dns_name
  ]
}

resource "aws_acm_certificate" "this" {
  domain_name       = "backend.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

output "acm_arn" {
  value = aws_acm_certificate.this.arn
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [aws_route53_record.web_cert_validation.fqdn]
  

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "web_cert_validation" {
  name = sort(aws_acm_certificate.this.domain_validation_options[*].resource_record_name)[0]
  type = sort(aws_acm_certificate.this.domain_validation_options[*].resource_record_type)[0]

  records = [sort(aws_acm_certificate.this.domain_validation_options[*].resource_record_value)][0]

  zone_id = data.aws_route53_zone.public.id
  ttl     = 60

  lifecycle {
    create_before_destroy = true
  }
}