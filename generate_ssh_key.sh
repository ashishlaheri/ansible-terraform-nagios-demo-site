
#!/bin/bash
set -e
KEY="$HOME/.ssh/wsl_deploy_key"
if [ -f "$KEY" ]; then
  echo "Key $KEY already exists, skipping generation."
  exit 0
fi
ssh-keygen -t rsa -b 4096 -f "$KEY" -N "" -C "wsl-deploy-key"
echo "Generated key $KEY and public $KEY.pub"
