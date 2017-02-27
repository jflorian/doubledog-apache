# == Class: apache::mod_wsgi
#
# Manages the Apache web server to provide the Web Server Gateway Interface.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*packages*]
#   An array of package names needed for the Apache web server with WSGI
#   installation.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2017 John Florian


class apache::mod_wsgi (
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
        notify => Class['::apache::service'],
    }

}
