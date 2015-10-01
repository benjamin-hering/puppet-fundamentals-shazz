define nginx::vhost (
  $docroot,
  $port       = '80',
  $servername = $title,
) {

  file { "/etc/nginx/conf.d/${title}.conf":
    ensure  => file,
    owner   => 'nginx',
    group   => 'nginx',
    mode    => '0644',
    content => template('nginx/vhost.conf.erb'),
  }

}

