
$apache_package=$osfamily?
		{
		  'redhat' => 'httpd',
		  'debian' => 'apache2',
		  'default' => 'apache2'
		}
package { $apache_package: 
  ensure => present
}

service { $apache_package:
  ensure => running,
  enable => true,
}
