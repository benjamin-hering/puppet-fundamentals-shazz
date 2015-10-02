class profiles::blog_platform {

  include apache
  include apache::mod::php
  include mysql::server
  include mysql::bindings
    apache::vhost { "$fqdn":
      port             => '80',
      manage_docroot   => false,
      docroot          => '/opt/wordpress',
    }  
  #mysql::db { 'wordpressdb': 
  #user     => 'db_user',
  #password => 'db_password',
  #dbname   => 'wordpress_db',
  #}
  include wordpress
}

