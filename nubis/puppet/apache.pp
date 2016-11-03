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

file { '/etc/apache2/conf-enabled/https-redirect.conf':
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0644',
  source  => 'puppet:///nubis/files/https-redirect.conf',
  require =>  Package['httpd'],
}

exec { '/usr/sbin/a2enmod rewrite':
  command => '/usr/sbin/a2enmod rewrite',
  require => Package['httpd'],
}
