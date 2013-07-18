# Public: Setup statsd service on system
#
# Examples
#
#   include statsd::service
class statsd::service {
  include statsd::config

  file { '/Library/LaunchDaemons/dev.statsd.plist':
    content => template('statsd/dev.statsd.plist.erb'),
    owner   => 'root',
    group   => 'wheel',
    notify  => Service['dev.statsd'],
    require => [
      File[$statsd::config::executable],
    ]
  }

  file { $statsd::config::executable:
    content => template('statsd/statsd.erb'),
    mode    => '0755'
  }

  service { 'dev.statsd':
    ensure    => running
  }

  service { 'com.boxen.statsd':
    before  => Service['dev.statsd'],
    enable  => false
  }
}
