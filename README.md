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

