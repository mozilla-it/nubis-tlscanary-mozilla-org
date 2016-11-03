#!/bin/bash -l
# Update the local copy of this site's git repository
#

SOURCE_REPO=https://github.com/mwobensmith/ssl_compat.git
REPO_DIR=/var/lib/ssl_compat

mkdir -p $REPO_DIR

# Clone the repository if the local repo is empty or non-existent
if [ ! -d $REPO_DIR/.git ]
then
  rm -rf $REPO_DIR
  /usr/bin/git clone $SOURCE_REPO $REPO_DIR
fi

# Otherwise, let's just git pull when needed
cd $REPO_DIR
/usr/bin/git remote update

LOCAL_REV=$(/usr/bin/git rev-parse master)
REMOTE_REV=$(/usr/bin/git rev-parse origin/master)

# git pull if master and origin/master do not match
# The local repository should never be ahead of origin/master
if [ $LOCAL_REV != $REMOTE_REV ]
then
  /usr/bin/git pull
  /usr/bin/git describe --always --tags --dirty > _revision.info
fi

