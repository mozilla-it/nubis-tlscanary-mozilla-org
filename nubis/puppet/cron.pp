cron { 'update-site.sh':
  command => '/bin/bash /opt/admin-scripts/update-site.sh',
  user    => 'root',
  minute  => [15, 45],
}
