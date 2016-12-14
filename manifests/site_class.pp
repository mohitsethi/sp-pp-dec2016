class webserver {
  package { 'apache2': 
    ensure => installed
  }

  service { 'apache2':
    ensure => running,
    enable => true,
  }
}

node 'puppet-agent.emc2.com' {
  include 'webserver' 
}
