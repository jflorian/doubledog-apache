# modules/apache/manifests/mod_auth_kerb.pp
#
# == Class: apache::mod_auth_kerb
#
# Manages the Apache web server to provide authorization via Kerberos.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*packages*]
#   An array of package names needed for the Apache web server with Kerberos
#   installation.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2016-2017 John Florian


class apache::mod_auth_kerb (
        String[1]               $keytab_source,
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
        notify => Class['::apache::service'],
    }

    ::apache::misc_file { 'conf/http.keytab':
        source => $keytab_source,
    }

}
