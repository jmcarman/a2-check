#!/bin/bash
# Author: Jason Carman; jason.carman@senecapolytechnic.ca
# Date: March 14, 2023
# Updated: Februrary 9, 2024
# Purpose: Generate a text file submission for Assignment 2
# Usage: Run this on deb3, then copy the output file to your host.

if [[ $(whoami) != "root" ]]; then
  echo "You must be root to run this script. Please use sudo." 2> /dev/null
  exit 1
fi

read -p "Please enter your userID: " user

cat << EOF > /home/$user/a2output.txt
Username: $user
Unique ID: $(echo $user | sha256sum)

#####
# Apache status:
$(systemctl status apache2)

#####
# Mariadb status:
$(systemctl status mariadb)

#####
# Wordpress installed:
$(ls -la /var/www/html/wordpress)

#####
# Wordpress config:
$(head -30 /var/www/html/wordpress/wp-config.php)

#####
# Firewall configuration:
$(iptables -L -vn --line-numbers)

EOF

echo "a2output.txt has been created in your home directory.  Please submit it to the Assignment 2 folder on BlackBoard."