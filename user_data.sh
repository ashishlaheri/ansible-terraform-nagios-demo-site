#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x

# Update and install Apache (Ubuntu)
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y apache2

# Create webroot and copy basic pages (if not present)
mkdir -p /var/www/html
cat > /var/www/html/index.html <<'EOF'
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>Index</title></head>
<body><h1>Auto-provisioned index.html</h1><p>Instance boot at: $(date)</p></body></html>
EOF

cat > /var/www/html/sample_status.html <<'EOF'
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>sample status</title></head>
<body><h1>Sample Status</h1><p>Created at $(date)</p></body></html>
EOF

# Ensure permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Enable and start apache
systemctl enable apache2
systemctl restart apache2

echo "user-data script finished at $(date)"
