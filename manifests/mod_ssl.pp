#
# == Class: apache::mod_ssl
#
# Manages the Apache web server to provide HTTPS support.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2014-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class apache::mod_ssl (
        Boolean                 $manage_firewall,
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
        notify => Class['apache::service'],
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
