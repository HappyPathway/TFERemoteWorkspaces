terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "AWSDemoDarnoldTFE"
    workspaces {
      prefix = "ec2-"
    }
  }
}
