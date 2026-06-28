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
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAACFwAAAAdzc2gtcn
NhAAAAAwEAAQAAAgEAyUxzZFvbMJKK/t1BKsqdVGymvta//1rN43lsS0N69mfmrVZlR3Mf
m27gN0vqYhuhe/fo3gFmFHJQGOi3PsjKHI7R8unsI/XzkJLIF9l3ms0E7jtoNcc3BiGhqN
Ex5JASYDaxGLaUhyDNM1J7J+YQWp94uQaCZcUgAGjwnLlAuN2wfSm1jHX1GsWzVZuFz2eA
Plycy4H5oUVmFqvfyemGhCc8lBdZhm8rxHPIL6G4d1GFN/fQSPmM+qro24N5uboQFK7EQH
3gGIYRxHUcWRGyjcZiP9g2EOCZlRqPff1f1OjZSZMMnZlADB32vnT0pGOPQq350ZCKtO5K
wi6qPIsubumd0j4HtFBtjBqhf9D/pwjZwDkVEEI1pwALJyqn9CC3WViLcAX4uZtRw38Zp8
n1qOly3nk2llPJzq5SwFNGytR4ap4hWEDgD+xzCm/u3n0lqAf1Bm3ElVPoW8NE/b3fiIqa
kg6GIHQvSUBc24Gu7Uzssqg5EshCmItMy7N3Rf5YjBU6w30y84u+o74uDw34zqIfrlzZrh
+Yg4ljCi3fa/hbQ6V2HqXR/EwXlrUc8/DU6KCAJ4ZmpP/6uyWvEpY5PUsl1Vs3URA4HAZy
EGc86lQ9FwuXzbeka0kYdkKonkJv6K3oCxoCIfl6kt+rfkT7+jCcfoLJqhFdlCJmMclrln
cAAAdQH7IkQx+yJEMAAAAHc3NoLXJzYQAAAgEAyUxzZFvbMJKK/t1BKsqdVGymvta//1rN
43lsS0N69mfmrVZlR3Mfm27gN0vqYhuhe/fo3gFmFHJQGOi3PsjKHI7R8unsI/XzkJLIF9
l3ms0E7jtoNcc3BiGhqNEx5JASYDaxGLaUhyDNM1J7J+YQWp94uQaCZcUgAGjwnLlAuN2w
fSm1jHX1GsWzVZuFz2eAPlycy4H5oUVmFqvfyemGhCc8lBdZhm8rxHPIL6G4d1GFN/fQSP
mM+qro24N5uboQFK7EQH3gGIYRxHUcWRGyjcZiP9g2EOCZlRqPff1f1OjZSZMMnZlADB32
vnT0pGOPQq350ZCKtO5Kwi6qPIsubumd0j4HtFBtjBqhf9D/pwjZwDkVEEI1pwALJyqn9C
C3WViLcAX4uZtRw38Zp8n1qOly3nk2llPJzq5SwFNGytR4ap4hWEDgD+xzCm/u3n0lqAf1
Bm3ElVPoW8NE/b3fiIqakg6GIHQvSUBc24Gu7Uzssqg5EshCmItMy7N3Rf5YjBU6w30y84
u+o74uDw34zqIfrlzZrh+Yg4ljCi3fa/hbQ6V2HqXR/EwXlrUc8/DU6KCAJ4ZmpP/6uyWv
EpY5PUsl1Vs3URA4HAZyEGc86lQ9FwuXzbeka0kYdkKonkJv6K3oCxoCIfl6kt+rfkT7+j
CcfoLJqhFdlCJmMclrlncAAAADAQABAAACABiI62ruMTXnM+7Ndo2/JVREFpdzDZ1o6r2m
L+IFMbMKcJjBoNWHvXCl9R54RR3mbT/ICcd+rHujKopmruha88YYTZRJw6uRujlC/Vq+zu
+nZnRHpF4i+ly9HlA5CII/DHun9DI6wA6vm6Mnk0rbz97OdMSPJmHowrZEvshIt2VGNqaC
vhXbzgnl0oOwJtaOhcMpaZOlCLvfKArCXHk72oE4AQ+xwDUno/zX+dcoYxc+mzn6R+uPvb
RTFCT744sUwl9VpSY70WOxJPA+L+bWm93g3K/DFrqRjYFEEVI+CX9QpCSYujRpQzUBiptQ
c6hSWYSQjOmTMFIjgH7Qzj9T3XmVlmDSt2hVADVPA0FppDqgWRnFENdAxIEKT3N0Bs5oCG
gPzZyDgQWWTldvkDLF7D9q7OtMoIw9gc2qNU9TyjPIk/IlS/teyWb0T2kTPn81BsmWASU6
R7MDI1CfJeZhI9H1Q3FcCg4qBb6th6uUjpLJkhI2N69AcKtFAczzkO0DzhnaEobcXbowbw
CagB+hN0ifQ6mnW85FEaUQ9eETtSu0K6WeAo0VJ+crK2NVSxOGmlIWzrHxjvAGWL0rgdk2
G0xv7TceLQNDib1NKKvmlOmTN8oVdGsPhMg3fNTegPojG9m1SRpIRxVSfufP7oYe32n7C9
RT3I4bUnJcp0T7KPCtAAABAGmfOEG69vIaOdZyyirzHj1jFkrVHXjyoVUBM+Nfffo0/eJY
8UQcMPZwD6NN9zWcZMSQmhJhtaIVGiHttA/a+/sgBgOD23MWLQ6iNZl+Q9cJzl/ODbe0NU
K9ey+peRlPTdjXi2mMW8mCCPrQRXxEr86lc0QfsxrPzudo4x3MQQmiZWyrZtGpG3F58P6W
rjugGUUth1N3tO5ux2MwcJYvL4b+OOJWxPQ6DDv1Q0z6dzaweTDjbWSHktzL0B/Eg8WPT/
HkKfhpeffEPQd6NIm23OXhC7GbwsYaG7XnTbI51Ar9piKcz0DNK7evrdmTRtPPyVGVYVbM
FKdxHBebhTmFAToAAAEBAOgGdYkMts4o/rxX1qpkIj59ntR2gDqSdZcbvMgbUoS3CynRdX
gAcd2aQsVQa/kunLuLQ48brNKNKx3AflMsM7F1cdjb0U4km2yvCg+sH6AqVAFeipuk257d
XAbg51TLepbNrTM0GYL80gxVtTYaq1JJmqG4RSWnGnPvcVUSXmhe4ZkDutgQ+cuMLghX51
4uvBonh8lk6hvWTLvW4muckEHb8WiydfM9UICrPh5esTiGiGHleW0EnBhzJdc6CMAtqFpJ
uhAh3ELRhr0AecOJ4c5iYFSbrppj0L8u83lts/Da7e35rjABCnxvrGEmjm4MpJKAT6RFWv
0t9Jbjrk9LiN0AAAEBAN4ZNeHYu+RaBpBxJE/kdVnnfZjnQqOrUXQzXHMnKAxevUR17dlQ
tz/f1s/LPfADgd4PfOj3ijeB4Uuq1osKICsPJgFEoTgzKProFNLRDz78qlLZ3+7J3OFs4i
7MhzXHJoEcndpyeE6IBMfJxdDeyWbX8EJ6904j3+SeWsHxBOXPb8xk5c0CW5Rpkl9Z4GOC
wil7A396+UMovS9tE9fVLJ1E4x0vgAFMWnaZXR+OjRrL/trhe9VQsvegK19FgM1vOwlzyr
iNg0VOPe+bSuktI6n6RaZRxtJvLHKvmnhSmwGHqex9gagNYRX6KpkAjBSckWPJl5ku4k3U
Thx6Y+ftPWMAAAAWeW91ci1lbWFpbEBleGFtcGxlLmNvbQECAwQF
-----END OPENSSH PRIVATE KEY-----
root@178c45c19ff5:/# ssh -T git@github.com
Hi cloudgitwrk! You've successfully authenticated, but GitHub does not provide shell access.
````
