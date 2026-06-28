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
