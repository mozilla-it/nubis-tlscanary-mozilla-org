# Define how Apache should be installed and configured
# We should try to recycle the puppetlabs-apache puppet module in the future:
# https://github.com/puppetlabs/puppetlabs-apache
#

package { 'httpd':
  ensure => latest,
  name => $::osfamily ? {
    'RedHat' => 'httpd',
    'Debian' => 'apache2'
  }
}

service { 'httpd':
  ensure => running,
  enable => true,
  hasrestart => true,
  hasstatus => true,
  restart => '/usr/bin/apachectl graceful',
  start => '/usr/sbin/apachectl start',
  status => '/etc/init.d/httpd status',
  require => Package['httpd'],
  name => $::osfamily ? {
    'RedHat' => 'httpd',
    'Debian' => 'apache2'
  }
}

file { '/etc/apache2/conf-enabled/https-redirect.conf':
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0644',
  source  => 'puppet:///nubis/files/https-redirect.conf',
  require =>  Package['httpd'],
}

exec { 'a2enmod rewrite':
  command => 'a2enmod rewrite',
  require => Package['httpd'],
}
