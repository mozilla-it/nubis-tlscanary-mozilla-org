#!/bin/bash -l
# Copy repository contents to web root
#

REPO_DIR=/var/lib/ssl_compat

/opt/admin-scripts/update-repo.sh

# Write to web root: /var/www/html
/usr/local/bin/atomic-rsync -a --cvs-exclude --delete $REPO_DIR/ /var/www/html/
