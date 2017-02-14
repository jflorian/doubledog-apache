# modules/apache/manifests/mod_passenger.pp
#
# == Class: apache::mod_passenger
#
# Configures the Apache web server to provide Phusion Passenger support.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*packages*]
#   An array of package names needed for the Apache web server with Phusion
#   Passenger installation.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2017 John Florian


class apache::mod_passenger (
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
        notify => Class['::apache::service'],
    }

}
