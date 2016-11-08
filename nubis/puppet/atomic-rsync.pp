file { '/usr/local/bin/atomic-rsync':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source => 'puppet:///nubis/files/atomic-rsync',
}

file { [ '/var/www/html-1', '/var/www/html-2' ]:
  ensure  => 'directory',
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    Package['httpd'],
  ]
}

file { '/var/www/html':
  ensure  => 'link',
  force   => true,
  target  => '/var/www/html-2',
  require => [
    Package['httpd'],
  ]
}
