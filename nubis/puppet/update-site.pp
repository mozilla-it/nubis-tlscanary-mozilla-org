file { '/opt/admin-scripts':
  ensure => 'directory',
  owner  => root,
  group  => root,
  mode   => '0755',
}

file { '/opt/admin-scripts/update-site.sh':
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0755',
  source  => 'puppet:///nubis/files/update-site.sh',
  require => File['/opt/admin-scripts'],
}

file { '/opt/admin-scripts/update-repo.sh':
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0755',
  source  => 'puppet:///nubis/files/update-repo.sh',
  require =>  File['/opt/admin-scripts'],
}
