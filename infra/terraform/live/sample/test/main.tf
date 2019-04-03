//
//
//  @author Laurent Krishnathas
//  @version 2019/03/01
//

module "cognito_userpool" {
//  source = "../../../../../../devops-cd.git/terraform/modules/aws-cognito-userpool"
  source = "git::ssh://git-codecommit.eu-west-1.amazonaws.com/v1/repos/devops-cd//terraform/modules/aws-cognito-userpool?ref=v1.5"

  aws_region = "${var.aws_region}"
  name = "${var.name}"
  environment = "${var.environment}"

  cognito_user_pool_domain = "${var.name}-${var.environment}"
  metaDataFile =  "${file("okta_sso_saml.xml")}"
}

module cognito_user_pool_client {
  source = "../modules/cognito_user_pool_client"

  aws_region = "${var.aws_region}"
  name = "${var.name}"
  environment = "${var.environment}"

  userpool_id = "${module.cognito_userpool.user_pool_id}"
  cognito_callback_url = "${local.cognito_callback_url}"
}


module alb_sg {
  source = "../modules/alb_sg"

  aws_region = "${var.aws_region}"
  name = "${var.name}"
  environment = "${var.environment}"
//  vpc_id = "${module.vpc.vpc_id}"
  vpc_id = "${data.aws_vpc.this.id}"
  tags = "${local.tags}"

}

module "alb" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git?ref=v3.5.0"
  load_balancer_name = "${var.name}-${var.environment}"
  logging_enabled = "true"
  log_bucket_name = "${var.s3_alb_log_buket}"
  log_location_prefix = "${var.name}-${var.environment}-alb"
//  subnets = "${module.vpc.public_subnets}"
  subnets = "${data.aws_subnet_ids.public.ids}"
//  vpc_id = "${module.vpc.vpc_id}"
  vpc_id = "${data.aws_vpc.this.id}"


  idle_timeout = "300"

  extra_ssl_certs = "${local.extra_ssl_certs}"
  extra_ssl_certs_count = "${local.extra_ssl_certs_count}"

  https_listeners = "${local.https_listeners}"
  https_listeners_count = "${local.https_listeners_count}"
  http_tcp_listeners = "${local.http_tcp_listeners}"
  http_tcp_listeners_count = "${local.http_tcp_listeners_count}"
  target_groups = "${local.target_groups}"
  target_groups_count = "${local.target_groups_count}"

  security_groups = [
    "${module.alb_sg.id}"]
  tags = "${local.tags}"
}

module cognito_alb_rule {
  source = "../modules/cognito_alb_rule"

  user_pool_client_id = "${module.cognito_user_pool_client.id}"
  user_pool_arn= "${module.cognito_userpool.user_pool_arn}"
  cognito_user_pool_domain = "${var.name}-${var.environment}"
  target_group_arn  = "${module.alb.target_group_arns[0]}"
  listener_arn = "${module.alb.https_listener_arns[0]}"
}



//iam_instance_profile         = "dotmatics-devops-ssmrole"

module ec2 {
  source = "../modules/ec2"
  aws_region = "${var.aws_region}"
  name = "${var.name}"
  environment = "${var.environment}"
//  vpc_id = "${module.vpc.vpc_id}"
  vpc_id = "${data.aws_vpc.this.id}"

  //  subnet_id = "${module.vpc.public_subnets[0]}" //debug
//  subnet_id = "${module.vpc.private_subnets[0]}"
  subnet_id = "${data.aws_subnet_ids.private.ids[0]}"

  iam_instance_profile = "dotmatics-devops-ssmrole"
  alb_sg_id = "${module.alb_sg.id}"



//  sudo reboot

//  WARNING any change will create a new ec2 so need to configure via ansible
  user_data = <<-EOF
                #!/bin/bash
                set -u
                set -e
                set -x

                echo "starting user_data ..."
                sudo docker --version || true
                sudo aws --version || true

                sudo systemctl enable amazon-ssm-agent
                sudo systemctl start amazon-ssm-agent

                sudo amazon-linux-extras install docker -y
                sudo systemctl enable docker
                sudo systemctl start docker

                sudo docker --version

                sudo usermod -aG docker ec2-user
                sudo usermod -aG docker ssm-user

                sudo docker swarm init

                sudo docker service create --name tomcat  --publish published=80,target=8080  tomcat:8
                sudo docker ps
                echo "user_data finised"

                EOF
  tags = "${local.tags}"
  ebs_volume="${var.ebs_volume}"

}

resource "aws_alb_target_group_attachment" "https-9443" {
  target_group_arn      = "${module.alb.target_group_arns[0]}"
  target_id             = "${module.ec2.id}"
  port                  = "9443"
}

