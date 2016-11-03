#!/bin/bash -l
# Update the local copy of this site's git repository
#

SOURCE_REPO=https://github.com/mwobensmith/ssl_compat.git
REPO_DIR=/var/lib/ssl_compat

# Ensure the repo is tidy
cleanup () {
  cd $REPO_DIR
  /usr/bin/git describe --always --tags --dirty > _revision.info
  find $REPO_DIR -type d \! -perm 0755 -exec chmod 0755 {} \;
  find $REPO_DIR -type f \! -perm 0644 -exec chmod 0644 {} \;
}

# Clone the repository if the local repo is empty or non-existent
if [ ! -d $REPO_DIR/.git ]
then
  rm -rf $REPO_DIR
  /usr/bin/git clone $SOURCE_REPO $REPO_DIR
  cleanup
fi

# Otherwise, let's just git pull when needed
cd $REPO_DIR
/usr/bin/git remote update

LOCAL_REV=$(/usr/bin/git rev-parse master)
REMOTE_REV=$(/usr/bin/git rev-parse origin/master)

# git pull if master and origin/master do not match
# The local repository should never be ahead of origin/master
if [ "$LOCAL_REV" != "$REMOTE_REV" ]
then
  /usr/bin/git pull
  cleanup
fi
