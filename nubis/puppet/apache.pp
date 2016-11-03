# Define how Apache should be installed and configured
# We should try to recycle the puppetlabs-apache puppet module in the future:
# https://github.com/puppetlabs/puppetlabs-apache
#

include nubis_discovery

nubis::discovery::service { "$project_name":
 tags     => [ 'apache' ],
 port     => 80,
 check    => "/usr/bin/curl -If http://localhost:80",
 interval => '30s',
}

package { 'httpd':
  ensure => latest,
  name => $::osfamily ? {
    'RedHat' => 'httpd',
    'Debian' => 'apache2'
  }
}

service { 'httpd':
  ensure => stopped,
  enable => false,
  require => Package['httpd'],
  name => $::osfamily ? {
    'RedHat' => 'httpd',
    'Debian' => 'apache2'
  }
}
