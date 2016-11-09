Travis CI: [![Travis Status](https://travis-ci.org/mozilla-it/nubis-tlscanary-mozilla-org.svg?branch=master)](https://travis-ci.org/mozilla-it/nubis-tlscanary-mozilla-org)

Jenkins build and deployment status: [![Jenkins Build Status](https://ci.tlscanary.admin.us-west-2.tlscanary.nubis.allizom.org/job/tlscanary-build/badge/icon)](https://ci.tlscanary.admin.us-west-2.tlscanary.nubis.allizom.org/job/tlscanary-build/)
[![Jenkins Deployment Status](https://ci.tlscanary.admin.us-west-2.tlscanary.nubis.allizom.org/job/tlscanary-deployment/badge/icon)](https://ci.tlscanary.admin.us-west-2.tlscanary.nubis.allizom.org/job/tlscanary-deployment/)

# tlscanary Nubis deployment repository

## Objective

This deployment repository defines how the tlscanary infrastructure is setup in
AWS. You'll find the tlscanary repository, ssl_compat, as a Git submodule
alongside a nubis directory which houses Packer, Puppet and Terraform
configuration files.

## How to use this

When you commit a change to the master branch in this repository, it will
trigger a job on the Jenkins server to build a new go through the Nubis build
process, perform any provisioning and apply the Terraform configuration.

## Future changes

In the future I would like to focus on the following changes:

- Trigger a Jenkins build when the tlscanary project, ssl_compat on GitHub, has
  a commit pushed to the master branch. This would be more in-line with the
  Nubis philosophy.

- Consider including some sort of scheduled job, via Lambda if applicable, to
  perform the build process that the tlscanary owner is performing manually.
  This should programmatically perform this work and build an updated website
  without requiring human intervention. It will eliminate the need for a cron
  job that updates the web root with new content sourced from GitHub and we can
  see immediate updates rather than waiting up to 30 minutes for the cron job to
  run.

- Evaluate whether or not we can host this website from an S3 bucket rather than
  an EC2 instance running Apache.
