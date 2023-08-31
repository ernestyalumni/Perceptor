#!/bin/sh

# Setting the root password
sudo passwd root

# https://www.cyberciti.biz/faq/add-new-user-account-with-admin-access-on-linux/

adduser bbblack

# make user admin.
usermod -aG sudo bbblack

# Verify making user admin.
id bbblack

# Log in as newly created user
su - bbblack

# m for machine architecture; expected to be armv7l
uname -m