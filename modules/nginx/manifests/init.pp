class nginx (
  $nginx_doc_root = $nginx::params::nginx_doc_root,
  $nginx_cfg      = $nginx::params::nginx_cfg,
  $nginx_default  = $nginx::params::nginx_default,
  $index_file     = $nginx::params::index_file,
) inherits nginx::params {

  package { 'nginx':
    ensure => present,
  }

  file { "${nginx_doc_root}":
    ensure => 'directory',
    #mode   => '0755',
    #owner => 'root',
    #group => 'root',
  }

  file { "${index_file}":
    ensure  => 'file',
    path    => "${nginx_doc_root}/index.html",
    content => template('nginx/index.html.erb'),
  }

  file { "${nginx_cfg}":
    ensure => 'file',
    source => 'puppet:///modules/nginx/nginx.conf',
  }

  #  file { "${nginx_default}":
  #    ensure => 'file',
  #    source => 'puppet:///modules/nginx/default.conf',
  #  }

  nginx::vhost { 'default':
    docroot => $nginx_doc_root,
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure    => 'running',
    enable    => 'true',
    subscribe => File["${nginx_cfg}"],
  }

}
