#
# == Class: apache
#
# Manages the Apache web server.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2010-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class apache (
        Boolean             $anon_write,
        Boolean             $execmem,
        Optional[Enum['emerg', 'alert', 'crit', 'error', 'warn', 'notice', 'info', 'debug']]
                            $log_level,
        Boolean             $manage_firewall,
        Boolean             $network_connect,
        Boolean             $network_connect_db,
        Boolean             $network_relay,
        Boolean             $use_nfs,
    ) {

    include '::apache::package'
    include '::apache::service'

    file {
        default:
            owner     => 'root',
            group     => 'root',
            mode      => '0640',
            seluser   => 'system_u',
            selrole   => 'object_r',
            seltype   => 'httpd_config_t',
            before    => Class['::apache::service'],
            notify    => Class['::apache::service'],
            subscribe => Class['::apache::package'],
            ;
        '/etc/httpd/conf/httpd.conf':
            content  => template("apache/httpd.conf.${::operatingsystem}.${::operatingsystemmajrelease}"),
            ;
    }

    if $manage_firewall {
        firewall { '500 accept HTTP packets':
            dport  => '80',
            proto  => 'tcp',
            state  => 'NEW',
            action => 'accept',
        }
    }

    selinux::boolean {
        default:
            before     => Class['::apache::service'],
            persistent => true,
            ;
        'httpd_anon_write':
            value => $anon_write,
            ;
        'httpd_can_network_connect':
            value => $network_connect,
            ;
        'httpd_can_network_connect_db':
            value => $network_connect_db,
            ;
        'httpd_can_network_relay':
            value => $network_relay,
            ;
        'httpd_execmem':
            value => $execmem,
            ;
        'httpd_use_nfs':
            value => $use_nfs,
            ;
    }

}
