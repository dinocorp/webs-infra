#!/usr/bin/env bash
set -eux -o pipefail
locale-gen en_GB.UTF-8

# Secure FW by default
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh

ufw allow http
ufw allow https

apt-get update -y
apt-get install -y curl git wget


# In reality you would install and configure a config management tool here.

apt-get install -y nginx mysql-client

export INSTANCE_ID=`curl --raw http://169.254.169.254/latest/meta-data/instance-id`
export PRIVATE_IP=`curl --raw http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body>
<ul>
<li>Instance ID: $${INSTANCE_ID}</li>
<li>Private IP: $${PRIVATE_IP}</li>
</body>
</html>
EOF

systemctl enable nginx.service
systemctl start nginx.service
