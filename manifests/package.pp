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
# [*names*]
#   An array of package names needed for the Apache web server installation.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2015-2017 John Florian


class apache::package (
        Array[String[1], 1]     $names,
    ) {

    package { $names:
        ensure => installed,
        notify => Class['::apache::service'],
    }

}
