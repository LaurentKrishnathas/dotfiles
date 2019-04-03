//
//
//  @author Laurent Krishnathas
//  @version 2018/04/01
//

provider "aws" {
  region = "${var.aws_region}"
  profile = "devops-dev"
  version = "~> 1.43"
}