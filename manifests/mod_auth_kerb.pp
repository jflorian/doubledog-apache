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
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2016 John Florian


class apache::mod_auth_kerb (
        String[1] $keytab_source,
    ) inherits ::apache::params {

    package { $::apache::params::modauthkrb_packages:
        ensure => installed,
        notify => Service[$::apache::params::services],
    }

    ::apache::misc_file { 'conf/http.keytab':
        source => $keytab_source,
    }

}
