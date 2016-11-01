#!/bin/bash
# Copy repository contents to web root
#

cd /tmp

# In this environment, git clone fails when run as root
su - ubuntu -c "/bin/bash /opt/admin-scripts/update-repo.sh"

# Remove unwanted content before publishing
mkdir /tmp/clean_www
cp -r /tmp/ssl_compat/* /tmp/clean_www

# Remove files from /tmp/clean_www
rm -rf /tmp/clean_www/.git*
rm -rf /tmp/clean_www/.svn*
rm -rf /tmp/clean_www/CVS
rm -rf /tmp/clean_www/.bzr*

# Set appropriate permissions for files and directories
find /tmp/clean_www -type d -exec chmod 755 {} \;
find /tmp/clean_www -type f -exec chmod 644 {} \;

# Write to web root: /var/www/html
cp -rf /tmp/clean_www/* /var/www/html

# Cleanup to prepare for the next run
rm -rf /tmp/clean_www

# Make sure unwanted index.html (default Apache page) does not exist:
rm -rf /var/www/html/index.html
