//
//
//  @author Laurent Krishnathas
//  @version 2018/04/01
//


output "single_signon_url" {
  value = "https://${var.name}-${var.environment}.auth.${var.aws_region}.amazoncognito.com/saml2/idpresponse"
}

output "audience_restriction" {
  value = "${module.cognito_userpool.sp_entity_id}"
}

output "name" {
  value = "${var.name}"
}

output "environment" {
  value = "${var.environment}"
}

output "ec2_private_ip" {
  value = "${module.ec2.private_ip}"
}

output "key_name" {
  value = "${module.ec2.key_name}"
}
