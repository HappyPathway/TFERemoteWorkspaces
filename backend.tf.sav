terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "AWSDemoDarnold"

    workspaces {
      prefix = "ec2-"
    }
  }
}
