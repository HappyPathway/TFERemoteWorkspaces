//--------------------------------------------------------------------
// Workspace Data
data "terraform_remote_state" "awsdemo_darnold_network" {
  backend = "atlas"
  config {
    name    = "AWSDemoDarnold/Network"
  }
}

//--------------------------------------------------------------------
// Modules
module "ec2_instance" {
  source  = "app.terraform.io/AWSDemoDarnold/ec2-instance/aws"
  version = "2.0.0"

  instance_name = "DarnoldDemo"
  instance_type = "m4.large"
  key_name = "tfe-demos-darnold"
  subnet_id = "${element(data.terraform_remote_state.awsdemo_darnold_network.public_subnets, 0)}"
}
 
 # yup, this counts as a change! :)
