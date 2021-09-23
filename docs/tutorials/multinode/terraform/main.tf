variable "project" {
  type=string
}
variable "project_id" {
  type=string
}
variable "zone" {
  type=string
}
variable "region" {
  type=string
}
variable "multizone" {
  type=bool
}
variable "numzones" {
  type=string
}

variable "cluster_name" {
  type = string
  default = "c"
  description = "Name used to prefix resources in cluster."

}
variable "family" {
  type=string
}

module "htcondor" {
  source = "./htcondor/"
  cluster_name = var.cluster_name
  project = var.project
  project_id = var.project_id
  zone = var.zone
  region = var.region
  multizone = var.multizone
  numzones = var.numzones
  family = var.family
  osversion = "7"
  max_replicas=20
  min_replicas=0
  compute_instance_type = "custom-2-11264"
  service_account="htcondor@${var.project}.iam.gserviceaccount.com"
  use_preemptibles=false
  osproject ="centos-cloud"
  osimage ="centos-7"
}