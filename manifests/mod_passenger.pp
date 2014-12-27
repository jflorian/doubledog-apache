# modules/apache/manifests/mod_passenger.pp
#
# == Class: apache::mod_passenger
#
# Configures the Apache web server to provide Phusion Passenger support.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class apache::mod_passenger {

    package { $apache::params::modpassenger_packages:
        ensure => installed,
        notify => Service[$apache::params::services],
    }

}
