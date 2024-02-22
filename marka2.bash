#!/bin/bash
# Author: Jason Carman; jason.carman@senecapolytechnic.ca
# Date: March 14, 2023
# Updated: Februrary 22, 2024
# Purpose: Generate a text file submission for Assignment 2
# Usage: Run this on the Ubuntu VM you created in your Assignment 1, then copy the output file to your host.
#

clear

if [[ $(whoami) != "root" ]]; then
  echo "You must be root to run this script. Please use sudo." 2> /dev/null
  exit 1
fi

read -p "Please enter your username: " user

cat << EOF > /home/$user/a2output.txt
Username: $user
Unique ID: $(echo $user | sha256sum)

#####
# Current default target:
$(systemctl get-default)

#####
# IP Address:
$(ip a)

#####
# Apache status:
$(systemctl status apache2)

#####
# Mariadb status:
$(systemctl status mariadb)

#####
# Wordpress installed:
$(ls -la /usr/share/wordpress)

#####
# Wordpress config:
$(head -10 /etc/wordpress/config-$user-ubuntu.php)
EOF

echo "a2output.txt has been created in your home directory.  Please submit it to the Assignment 2 folder on BlackBoard."