//
//
//  @author Laurent Krishnathas
//  @version 2018/04/01
//

locals {
  tags = "${map("Environment", "${var.environment}",
                "Project", "${var.name}",
                "Workspace", "${terraform.workspace}",
                "Terraform", "true",
                "Name", "${var.name}-${var.environment}"

  )}"


  https_listeners_count = 1
  https_listeners = "${list(
                        map(
                            "certificate_arn", "${var.certificate_dotmatics_click_arn}",
                            "port", 443,
                            "ssl_policy", "ELBSecurityPolicy-TLS-1-2-2017-01",
                            "target_group_index", 0
                        )
  )}"

  http_tcp_listeners_count = 0
  http_tcp_listeners = "${list(
                            map(
                                "port", 80,
                                "protocol", "HTTP"
                            )
  )}"

  target_groups_count = 1
  target_groups = "${list(
                        map("name", "${var.name}-${var.environment}-https-443",
                            "backend_protocol", "HTTP",
                            "backend_port", 443 ,
                            "health_check_path", "/",
                            "health_check_interval", "60",
                            "health_check_matcher", "200-399"
                        )
  )}"

  extra_ssl_certs_count = 1
  extra_ssl_certs = "${list(
                        map( "certificate_arn", "${var.certificate_dotmatics_com_arn}",
                             "https_listener_index", 0 )
  )}"

 cognito_callback_url= "https://${var.name}.dotmatics.com/oauth2/idpresponse"




  # helpful for debugging
  #   https_listeners_count    = 0
  #   https_listeners          = "${list()}"
  #   http_tcp_listeners_count = 0
  #   http_tcp_listeners       = "${list()}"
  #   target_groups_count      = 0
  #   target_groups            = "${list()}"
  #   extra_ssl_certs_count    = 0
  #   extra_ssl_certs          = "${list()}"
}