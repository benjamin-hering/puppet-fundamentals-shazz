class nginx::params {
  case $::osfamily {
    'RedHat' : {
      $nginx_doc_root = '/var/www'
      $nginx_cfg      = '/etc/nginx/nginx.conf'
      $nginx_default  = '/etc/nginx/conf.d/default.conf'
      $index_file     = '/var/www/index.html'
    }
    default: {
      fail("Not supported OS")
    }
  }
}
