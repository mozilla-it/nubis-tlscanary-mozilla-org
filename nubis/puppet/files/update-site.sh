#!/bin/bash -l
# Copy repository contents to web root
#

REPO_DIR=/var/lib/ssl_compat
SOURCE_REPO=https://github.com/mwobensmith/ssl_compat.git

# Ensure the repo is tidy
cleanup () {
  cd $REPO_DIR || exit
  /usr/bin/git describe --always --tags --dirty > _revision.txt
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
cd $REPO_DIR || exit
/usr/bin/git remote update

LOCAL_REV=$(/usr/bin/git rev-parse master)
REMOTE_REV=$(/usr/bin/git rev-parse origin/master)

# git pull if master and origin/master do not match
# The local repository should never be ahead of origin/master
if [ "$LOCAL_REV" != "$REMOTE_REV" ]
then
  /usr/bin/git pull
  cleanup

  # Write to web root: /var/www/html
  /usr/local/bin/atomic-rsync -a --cvs-exclude --delete $REPO_DIR/ /var/www/html/
fi


