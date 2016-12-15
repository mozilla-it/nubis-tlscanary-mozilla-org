cron { 'update-site.sh':
  command => 'nubis-cron update-site /opt/admin-scripts/update-site.sh',
  user    => 'root',
  minute  => [ fqdn_rand(30), ( fqdn_rand(30) + 30 ) % 60],
}
