class nginx::params {
  case $::osfamily {
    'RedHat' : {
      $nginx_doc_root = hiera('nginx_doc_root')
      $nginx_cfg      = hiera('nginx_cfg')
      $nginx_default  = hiera('nginx_default')
      $index_file     = hiera('index_file')
    }
    default: {
      fail("Not supported OS")
    }
  }
}
