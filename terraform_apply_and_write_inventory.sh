#!/bin/bash
set -e
# run from project folder where main.tf resides
terraform init
terraform apply -auto-approve

IP=$(terraform output -raw public_ip)
if [ -z "$IP" ]; then
  echo "Failed to get public_ip from terraform outputs"
  exit 1
fi

cat > inventory.ini <<EOF
[web]
ec2-server ansible_host=$IP ansible_user=ubuntu ansible_ssh_private_key_file=$HOME/.ssh/wsl_deploy_key.pem
EOF

# ensure key perms
chmod 600 $HOME/.ssh/wsl_deploy_key.pem

# run ansible
ansible-playbook -i inventory.ini site.yml -v
