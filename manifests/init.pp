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
        Boolean                     $anon_write,
        Boolean                     $execmem,
        Optional[Apache::Log_level] $log_level,
        Boolean                     $manage_firewall,
        Boolean                     $network_connect,
        Boolean                     $network_connect_db,
        Boolean                     $network_relay,
        Boolean                     $send_mail,
        Boolean                     $use_nfs,
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
            content  => template('apache/httpd.conf.erb'),
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
            ensure => $anon_write,
            ;
        'httpd_can_network_connect':
            ensure => $network_connect,
            ;
        'httpd_can_network_connect_db':
            ensure => $network_connect_db,
            ;
        'httpd_can_network_relay':
            ensure => $network_relay,
            ;
        'httpd_can_sendmail':
            ensure => $send_mail,
            ;
        'httpd_execmem':
            ensure => $execmem,
            ;
        'httpd_use_nfs':
            ensure => $use_nfs,
            ;
    }

}
