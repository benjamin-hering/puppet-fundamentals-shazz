# Class: nginx
# ===========================
#
# Full description of class nginx here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'nginx':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class nginx (
  $nginx_doc_root = '/var/www',
  $nginx_cfg      = '/etc/nginx/nginx.conf',
  $nginx_default  = '/etc/nginx/conf.d/default.conf',
  $index_file     = '/var/www/index.html',
  #$nginx_site     = 'default',
) {

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
