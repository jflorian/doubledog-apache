# modules/apache/manifests/package.pp
#
# == Class: apache::package
#
# Manages the Apache web server packages.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2015-2016 John Florian


class apache::package (
    ) inherits ::apache::params {

    package { $::apache::params::packages:
        ensure => installed,
        notify => Service[$::apache::params::services],
    }

}
