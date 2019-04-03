
data "aws_availability_zones" "all" {}



data "aws_vpc" "this"{
  filter {
    name   = "tag:Name"
    values = ["devopsdev-private-vpc"]
  }
}

data "aws_subnet_ids" "public"{
  vpc_id = "${data.aws_vpc.this.id}"
  filter {
    name = "tag:Tier"
    values = ["Public"]
  }
}
data "aws_subnet_ids" "private"{
  vpc_id = "${data.aws_vpc.this.id}"
  filter {
    name = "tag:Tier"
    values = ["Private"]
  }
}