```ruby
IMPORTANT NOTE (VERY IMPORTANT for Terraform)
🚨 terraform.tfvars usually contains:

API keys
Secrets
Sensitive data

👉 Best practice:
✅ Option 1 (Recommended)
Do NOT commit it:

echo "terraform.tfvars" >> .gitignore

git rm --cached terraform.tfvars
git add .gitignore
git commit -m "Ignore tfvars"
git push

Recommended Approach for Terraform
Instead of committing secrets:

Use Jenkins credentials
Pass via environment variables:

TF_VAR_atlas_public_key
TF_VAR_atlas_private_key
```
```
(venv) root@DELL-PERSONAL-LAPTOP:~# docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  jenkins/jenkins:lts
Unable to find image 'jenkins/jenkins:lts' locally
lts: Pulling from jenkins/jenkins
e0c565fe0e0f: Pull complete
f32f49ce655a: Pull complete
666cfcad1547: Pull complete
05a618d2b4a2: Pull complete
55d6369d34fc: Pull complete
2cf2bdb6424e: Pull complete
f8607bd7ae5d: Pull complete
93ee2f2f43be: Pull complete
6e5bee01636c: Pull complete
c904c8d615de: Pull complete
b7e7f4c38e4c: Pull complete
5ed85583fb30: Pull complete
3d311817a9b8: Download complete
Digest: sha256:e82bbdcffb6361c081ac66bbdcd5802a299b3631c78c3be04a0a91c7f952fff3
Status: Downloaded newer image for jenkins/jenkins:lts
178c45c19ff518963bb6f0254ab8246aea0555f68f439c64babf34527be7453d

(venv) root@DELL-PERSONAL-LAPTOP:~# docker ps
CONTAINER ID   IMAGE                 COMMAND                  CREATED              STATUS              PORTS                                                                                          NAMES
178c45c19ff5   jenkins/jenkins:lts   "/usr/bin/tini -- /u…"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp, 0.0.0.0:50000->50000/tcp, [::]:50000->50000/tcp   jenkins

`````

># (venv) root@DELL-PERSONAL-LAPTOP:~# docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

```ruby
93078b4c54154925b80b30d994b97096
````

````ruby
(venv) root@DELL-PERSONAL-LAPTOP:~/terraform-mongo# git add Jenkinsfile
git commit -m "Added Jenkins pipeline"
git push
[main 32dcde8] Added Jenkins pipeline
 1 file changed, 46 insertions(+)
 create mode 100644 Jenkinsfile
To github.com:cloudgitwrk/terraform-mongo.git
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs to 'github.com:cloudgitwrk/terraform-mongo.git'
hint: Updates were rejected because the remote contains work that you do not
hint: have locally. This is usually caused by another repository pushing to
hint: the same ref. If you want to integrate the remote changes, use
hint: 'git pull' before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
(venv) root@DELL-PERSONAL-LAPTOP:~/terraform-mongo# git pull origin main --no-rebase
remote: Enumerating objects: 22, done.
remote: Counting objects: 100% (22/22), done.
remote: Compressing objects: 100% (21/21), done.
remote: Total 21 (delta 13), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (21/21), 7.15 KiB | 457.00 KiB/s, done.
From github.com:cloudgitwrk/terraform-mongo
 * branch            main       -> FETCH_HEAD
   3d2f960..1b6dd92  main       -> origin/main
Merge made by the 'ort' strategy.
 README.md | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 README.md
(venv) root@DELL-PERSONAL-LAPTOP:~/terraform-mongo# git push
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 8 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 819 bytes | 819.00 KiB/s, done.
Total 5 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 1 local object.
To github.com:cloudgitwrk/terraform-mongo.git
   1b6dd92..8609990  main -> main
`````

````
(venv) root@DELL-PERSONAL-LAPTOP:~/terraform-mongo# docker exec -it -u root jenkins bash
root@178c45c19ff5:/# mkdir -p /root/.ssh
root@178c45c19ff5:/# ssh-keyscan github.com >> /root/.ssh/known_hosts
root@178c45c19ff5:/# chmod 600 /root/.ssh/known_hosts
root@178c45c19ff5:/# ssh -T git@github.com
git@github.com: Permission denied (publickey).
root@178c45c19ff5:/# vi /root/.ssh/id_rsa
bash: vi: command not found
root@178c45c19ff5:/# nano /root/.ssh/id_rsa
bash: nano: command not found
root@178c45c19ff5:/# cat <<EOF > /root/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
EOF
root@178c45c19ff5:/# chmod 600 /root/.ssh/id_rsa
root@178c45c19ff5:/# cat /root/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
root@178c45c19ff5:/# ssh -T git@github.com
Hi cloudgitwrk! You've successfully authenticated, but GitHub does not provide shell access.
````

````ruby
Started by user Venkatesh Reddy
Obtained Jenkinsfile from git git@github.com:cloudgitwrk/terraform-mongo.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/mongo-terraform-job
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
Cloning the remote Git repository
Cloning repository git@github.com:cloudgitwrk/terraform-mongo.git
 > git init /var/jenkins_home/workspace/mongo-terraform-job # timeout=10
Fetching upstream changes from git@github.com:cloudgitwrk/terraform-mongo.git
 > git --version # timeout=10
 > git --version # 'git version 2.47.3'
 > git fetch --tags --force --progress -- git@github.com:cloudgitwrk/terraform-mongo.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url git@github.com:cloudgitwrk/terraform-mongo.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision eed3d145a130a68d0e6cdad8d8f09cc6e20653f9 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f eed3d145a130a68d0e6cdad8d8f09cc6e20653f9 # timeout=10
Commit message: "Document SSH key setup for GitHub in README"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout Code)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
 > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/mongo-terraform-job/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url git@github.com:cloudgitwrk/terraform-mongo.git # timeout=10
Fetching upstream changes from git@github.com:cloudgitwrk/terraform-mongo.git
 > git --version # timeout=10
 > git --version # 'git version 2.47.3'
 > git fetch --tags --force --progress -- git@github.com:cloudgitwrk/terraform-mongo.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision eed3d145a130a68d0e6cdad8d8f09cc6e20653f9 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f eed3d145a130a68d0e6cdad8d8f09cc6e20653f9 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b main eed3d145a130a68d0e6cdad8d8f09cc6e20653f9 # timeout=10
Commit message: "Document SSH key setup for GitHub in README"
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
[Pipeline] sh
+ terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m
- Finding mongodb/mongodbatlas versions matching "~> 1.15"...
- Installing mongodb/mongodbatlas v1.41.1...
- Installed mongodb/mongodbatlas v1.41.1 (signed by a HashiCorp partner, key ID [0m[1m2A32ED1F3AD25ABF[0m[0m)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file [1m.terraform.lock.hcl[0m to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.[0m

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Validate)
[Pipeline] sh
+ terraform validate
[32m[1mSuccess![0m The configuration is valid.
[0m
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Plan)
[Pipeline] sh
+ terraform plan

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # mongodbatlas_cluster.cluster[0m will be created
[0m  [32m+[0m[0m resource "mongodbatlas_cluster" "cluster" {
      [32m+[0m[0m accept_data_risks_and_force_replica_set_reconfig = (known after apply)
      [32m+[0m[0m auto_scaling_compute_enabled                     = (known after apply)
      [32m+[0m[0m auto_scaling_compute_scale_down_enabled          = (known after apply)
      [32m+[0m[0m auto_scaling_disk_gb_enabled                     = (known after apply)
      [32m+[0m[0m backing_provider_name                            = "AWS"
      [32m+[0m[0m backup_enabled                                   = (known after apply)
      [32m+[0m[0m cloud_backup                                     = (known after apply)
      [32m+[0m[0m cluster_id                                       = (known after apply)
      [32m+[0m[0m cluster_type                                     = "REPLICASET"
      [32m+[0m[0m connection_strings                               = (known after apply)
      [32m+[0m[0m container_id                                     = (known after apply)
      [32m+[0m[0m disk_size_gb                                     = (known after apply)
      [32m+[0m[0m encryption_at_rest_provider                      = (known after apply)
      [32m+[0m[0m id                                               = (known after apply)
      [32m+[0m[0m mongo_db_major_version                           = (known after apply)
      [32m+[0m[0m mongo_db_version                                 = (known after apply)
      [32m+[0m[0m mongo_uri                                        = (known after apply)
      [32m+[0m[0m mongo_uri_updated                                = (known after apply)
      [32m+[0m[0m mongo_uri_with_options                           = (known after apply)
      [32m+[0m[0m name                                             = "tf-m0-cluster"
      [32m+[0m[0m num_shards                                       = (known after apply)
      [32m+[0m[0m paused                                           = (known after apply)
      [32m+[0m[0m pit_enabled                                      = (known after apply)
      [32m+[0m[0m project_id                                       = (known after apply)
      [32m+[0m[0m provider_auto_scaling_compute_max_instance_size  = (known after apply)
      [32m+[0m[0m provider_auto_scaling_compute_min_instance_size  = (known after apply)
      [32m+[0m[0m provider_disk_iops                               = (known after apply)
      [32m+[0m[0m provider_disk_type_name                          = (known after apply)
      [32m+[0m[0m provider_encrypt_ebs_volume                      = (known after apply)
      [32m+[0m[0m provider_encrypt_ebs_volume_flag                 = (known after apply)
      [32m+[0m[0m provider_instance_size_name                      = "M0"
      [32m+[0m[0m provider_name                                    = "TENANT"
      [32m+[0m[0m provider_region_name                             = "AP_SOUTH_1"
      [32m+[0m[0m provider_volume_type                             = (known after apply)
      [32m+[0m[0m redact_client_log_data                           = (known after apply)
      [32m+[0m[0m replication_factor                               = (known after apply)
      [32m+[0m[0m snapshot_backup_policy                           = (known after apply)
      [32m+[0m[0m srv_address                                      = (known after apply)
      [32m+[0m[0m state_name                                       = (known after apply)
      [32m+[0m[0m termination_protection_enabled                   = (known after apply)
      [32m+[0m[0m version_release_system                           = (known after apply)
    }

[1m  # mongodbatlas_project.project[0m will be created
[0m  [32m+[0m[0m resource "mongodbatlas_project" "project" {
      [32m+[0m[0m cluster_count                                    = (known after apply)
      [32m+[0m[0m created                                          = (known after apply)
      [32m+[0m[0m id                                               = (known after apply)
      [32m+[0m[0m ip_addresses                                     = (known after apply)
      [32m+[0m[0m is_collect_database_specifics_statistics_enabled = (known after apply)
      [32m+[0m[0m is_data_explorer_enabled                         = (known after apply)
      [32m+[0m[0m is_extended_storage_sizes_enabled                = (known after apply)
      [32m+[0m[0m is_performance_advisor_enabled                   = (known after apply)
      [32m+[0m[0m is_realtime_performance_panel_enabled            = (known after apply)
      [32m+[0m[0m is_schema_advisor_enabled                        = (known after apply)
      [32m+[0m[0m is_slow_operation_thresholding_enabled           = (known after apply)
      [32m+[0m[0m name                                             = "tf-test-project"
      [32m+[0m[0m org_id                                           = "65cb1f577520326ee15a5578"
      [32m+[0m[0m region_usage_restrictions                        = (known after apply)
      [32m+[0m[0m with_default_alerts_settings                     = true
    }

[1mPlan:[0m 2 to add, 0 to change, 0 to destroy.
[0m[90m
─────────────────────────────────────────────────────────────────────────────[0m

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Apply)
[Pipeline] sh
+ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # mongodbatlas_cluster.cluster[0m will be created
[0m  [32m+[0m[0m resource "mongodbatlas_cluster" "cluster" {
      [32m+[0m[0m accept_data_risks_and_force_replica_set_reconfig = (known after apply)
      [32m+[0m[0m auto_scaling_compute_enabled                     = (known after apply)
      [32m+[0m[0m auto_scaling_compute_scale_down_enabled          = (known after apply)
      [32m+[0m[0m auto_scaling_disk_gb_enabled                     = (known after apply)
      [32m+[0m[0m backing_provider_name                            = "AWS"
      [32m+[0m[0m backup_enabled                                   = (known after apply)
      [32m+[0m[0m cloud_backup                                     = (known after apply)
      [32m+[0m[0m cluster_id                                       = (known after apply)
      [32m+[0m[0m cluster_type                                     = "REPLICASET"
      [32m+[0m[0m connection_strings                               = (known after apply)
      [32m+[0m[0m container_id                                     = (known after apply)
      [32m+[0m[0m disk_size_gb                                     = (known after apply)
      [32m+[0m[0m encryption_at_rest_provider                      = (known after apply)
      [32m+[0m[0m id                                               = (known after apply)
      [32m+[0m[0m mongo_db_major_version                           = (known after apply)
      [32m+[0m[0m mongo_db_version                                 = (known after apply)
      [32m+[0m[0m mongo_uri                                        = (known after apply)
      [32m+[0m[0m mongo_uri_updated                                = (known after apply)
      [32m+[0m[0m mongo_uri_with_options                           = (known after apply)
      [32m+[0m[0m name                                             = "tf-m0-cluster"
      [32m+[0m[0m num_shards                                       = (known after apply)
      [32m+[0m[0m paused                                           = (known after apply)
      [32m+[0m[0m pit_enabled                                      = (known after apply)
      [32m+[0m[0m project_id                                       = (known after apply)
      [32m+[0m[0m provider_auto_scaling_compute_max_instance_size  = (known after apply)
      [32m+[0m[0m provider_auto_scaling_compute_min_instance_size  = (known after apply)
      [32m+[0m[0m provider_disk_iops                               = (known after apply)
      [32m+[0m[0m provider_disk_type_name                          = (known after apply)
      [32m+[0m[0m provider_encrypt_ebs_volume                      = (known after apply)
      [32m+[0m[0m provider_encrypt_ebs_volume_flag                 = (known after apply)
      [32m+[0m[0m provider_instance_size_name                      = "M0"
      [32m+[0m[0m provider_name                                    = "TENANT"
      [32m+[0m[0m provider_region_name                             = "AP_SOUTH_1"
      [32m+[0m[0m provider_volume_type                             = (known after apply)
      [32m+[0m[0m redact_client_log_data                           = (known after apply)
      [32m+[0m[0m replication_factor                               = (known after apply)
      [32m+[0m[0m snapshot_backup_policy                           = (known after apply)
      [32m+[0m[0m srv_address                                      = (known after apply)
      [32m+[0m[0m state_name                                       = (known after apply)
      [32m+[0m[0m termination_protection_enabled                   = (known after apply)
      [32m+[0m[0m version_release_system                           = (known after apply)
    }

[1m  # mongodbatlas_project.project[0m will be created
[0m  [32m+[0m[0m resource "mongodbatlas_project" "project" {
      [32m+[0m[0m cluster_count                                    = (known after apply)
      [32m+[0m[0m created                                          = (known after apply)
      [32m+[0m[0m id                                               = (known after apply)
      [32m+[0m[0m ip_addresses                                     = (known after apply)
      [32m+[0m[0m is_collect_database_specifics_statistics_enabled = (known after apply)
      [32m+[0m[0m is_data_explorer_enabled                         = (known after apply)
      [32m+[0m[0m is_extended_storage_sizes_enabled                = (known after apply)
      [32m+[0m[0m is_performance_advisor_enabled                   = (known after apply)
      [32m+[0m[0m is_realtime_performance_panel_enabled            = (known after apply)
      [32m+[0m[0m is_schema_advisor_enabled                        = (known after apply)
      [32m+[0m[0m is_slow_operation_thresholding_enabled           = (known after apply)
      [32m+[0m[0m name                                             = "tf-test-project"
      [32m+[0m[0m org_id                                           = "65cb1f577520326ee15a5578"
      [32m+[0m[0m region_usage_restrictions                        = (known after apply)
      [32m+[0m[0m with_default_alerts_settings                     = true
    }

[1mPlan:[0m 2 to add, 0 to change, 0 to destroy.
[0m[0m[1mmongodbatlas_project.project: Creating...[0m[0m
[0m[1mmongodbatlas_project.project: Creation complete after 8s [id=6a40cae2f18536d525db2172][0m
[0m[1mmongodbatlas_cluster.cluster: Creating...[0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [10s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [20s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [30s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [40s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [50s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [1m0s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [1m10s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [1m20s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [1m30s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [1m40s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [1m50s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [2m0s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [2m10s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [2m20s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [2m30s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [2m40s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [2m50s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Still creating... [3m0s elapsed][0m[0m
[0m[1mmongodbatlas_cluster.cluster: Creation complete after 3m5s [id=Y2x1c3Rlcl9pZA==:NmE0MGNhZWIwYzdjODQxNDIzNDJkOWQz-Y2x1c3Rlcl9uYW1l:dGYtbTAtY2x1c3Rlcg==-cHJvamVjdF9pZA==:NmE0MGNhZTJmMTg1MzZkNTI1ZGIyMTcy-cHJvdmlkZXJfbmFtZQ==:VEVOQU5U][0m
[0m[1m[32m
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
[0m
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] echo
✅ MongoDB Cluster Created Successfully
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
````

<img width="1678" height="6581" alt="image" src="https://github.com/user-attachments/assets/341721a6-dabd-4f05-b129-7f5b96a4aac5" />

