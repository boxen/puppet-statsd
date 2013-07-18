# Public: Installs statsd via npm, configures for graphite backend
#
# Examples
#
#   include statsd
class statsd {
  include statsd::service
  include statsd::config

  file { $statsd::config::configdir:
    ensure => 'directory'
  }

  file { $statsd::config::logdir:
    ensure => 'directory'
  }

  file { $statsd::config::configfile:
    content => template('statsd/config.js.erb'),
    notify  => Service['dev.statsd'],
  }

  repository { $statsd::config::libdir:
    provider  => 'git',
    source    => 'etsy/statsd'
  }

  file { "${boxen::config::envdir}/statsd.sh":
    content => template('statsd/env.sh.erb'),
    require => File[$boxen::config::envdir]
  }
}
