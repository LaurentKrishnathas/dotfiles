//
//
//  @author Laurent Krishnathas
//  @version 2018/04/01
//

terraform {
  required_version = "= 0.11.11"
  backend "s3" {
    bucket = "terraform-remote-state-devops-dotmatics-eu-west-1"
    key = "devpsdev/examples/basicV1"
    region = "eu-west-1"
    dynamodb_table = "terraform-remote-state"
    profile = "devops-dev"
  }
}