#!/bin/bash -l
# Update the local copy of this site's git repository
# Copy the contents to the web root.
#

SOURCE_REPO=https://github.com/mwobensmith/ssl_compat.git
LOCAL_REV=$(/usr/bin/git rev-parse master)
REMOTE_REV=$(/usr/bin/git rev-parse origin/master)

cd /tmp

# Clone the repository if the local repo is empty or non-existent
if [ ! -d /tmp/ssl_compat/.git ]
then
  rm -rf /tmp/ssl_compat
  /usr/bin/git clone $SOURCE_REPO
fi

# Otherwise, let's just git pull when needed
cd /tmp/ssl_compat
/usr/bin/git remote update

# git pull if master and origin/master do not match
# The local repository should never be ahead of origin/master
if [ $LOCAL_REV != $REMOTE_REV ]
then
  /usr/bin/git pull
fi
