resource "mongodbatlas_project" "project" {
  name   = "tf-test-project"
  org_id = var.org_id
}

resource "mongodbatlas_cluster" "cluster" {
  project_id = mongodbatlas_project.project.id
  name       = "tf-m0-cluster"

  cluster_type = "REPLICASET"

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "AP_SOUTH_1"
  provider_instance_size_name = "M0"
}
