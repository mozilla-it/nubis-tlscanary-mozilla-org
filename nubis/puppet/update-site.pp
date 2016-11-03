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

file { "/etc/nubis.d/${project_name}":
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0755',
  content => "#!/bin/bash -l
# Runs once on instance boot, after all infra services are up and running

# Pull latest version
/opt/admin-scripts/update-site.sh

# Start serving it
service ${::apache::params::service_name} start
"
}
