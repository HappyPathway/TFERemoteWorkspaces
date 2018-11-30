variable "organization" {
    type="string"
    description="Name of Terraform Enterprise Organization"
}


variable "github_org" {
    type="string"
    description="Github Organization"
    default="HappyPathway"
}


variable "vault_token" {
    type="string"
    description="Vault Token"
}


variable "vault_addr" {
    type="string"
    description="Vault Cluster Address"
}


variable "repo_name" {
    type="string"
    description="Name of Github Repo"
    default = "TFERemoteWorkspaces"
}


variable "workspace_name" {
    type="string"
    description="Name of TFE Workspace"
}

resource "tfe_organization_token" "token" {
    organization = "${var.organization}"
}

module "oauth_token" {
    source = "github.com/HappyPathway/terraform-tfe-oauth-token"
    tfe_org = "${var.organization}"
    tfe_token = "${tfe_organization_token.token.token}"
}

module "workspace" {
    source  = "app.terraform.io/Darnold-Hashicorp/demo-workspace/tfe"
    version = "2.5.4"
    github_org = "${var.github_org}"
    oauth_token = "${module.oauth_token.oauth_token}"
    organization = "${var.organization}"
    repo_name = "${var.repo_name}"
    workspace_name ="${var.workspace_name}"
    aws_vars = false
    aws_role = "ec2_admin"
    azure_vars = false
    gcp_vars = false
    vault_vars = true
    vault_addr = "${var.vault_addr}"
    vault_token = "${var.vault_token}"
    create_repo = false
    bind_repo = true
}
output "workspace_id" {
    value = "${module.workspace.workspace_id}"
    }
