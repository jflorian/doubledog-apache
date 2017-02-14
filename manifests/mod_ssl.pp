# modules/apache/manifests/mod_ssl.pp
#
# == Class: apache::mod_ssl
#
# Manages the Apache web server to provide HTTPS support.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*manage_firewall*]
#   If true, open the HTTPS port on the firewall.  Otherwise the firewall is
#   left unaffected.  Defaults to true.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2017 John Florian


class apache::mod_ssl (
        $manage_firewall,
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
        notify => Class['::apache::service'],
    }

    if $manage_firewall {
        firewall { '500 accept HTTPS packets':
            dport  => '443',
            proto  => 'tcp',
            state  => 'NEW',
            action => 'accept',
        }
    }

}
