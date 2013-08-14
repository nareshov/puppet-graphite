# == Class: graphite_reporter
#
# This class deploys and configures a puppet reporter to send reports to graphite
#
#
# === Parameters
#
# [*graphite_host*]
#   String.  Graphite host to write stats to
#   Default: 127.0.0.1
#
# [*graphite_port*]
#   Integer.  Port graphite is listening for tcp connections on
#   Default: 2003
#
# [*config_file*]
#   String.  Path to write the config file to
#   Default: /etc/puppet/graphite.yaml
#
#
# === Examples
#
# * Installation:
#     class { 'graphite_reporter':
#       graphite_host => 'graphite.mycompany.com',
#     }
#
#
# === Authors
#
# * Naresh V. <mailto:nareshov@gmail.com>
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
class graphite_reporter (
  $graphite_host  = '127.0.0.1',
  $graphite_port  = 2003,
  $config_file  = '/etc/puppet/graphite.yaml',
){

  file { $config_file:
    ensure  => file,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0444',
    content => template('graphite_reporter/graphite.yaml.erb'),
  }

}

