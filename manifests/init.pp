# modules/apache/manifests/init.pp
#
# == Class: apache
#
# Manages the Apache web server.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*anon_write*]
#   Configure SE Linux to allow httpd to modify public files used for public
#   file tranfer services.  One of: true or false (default).
#
# [*network_connect*]
#   Configure SE Linux to allow httpd scripts and modules to connect to the
#   network using TCP.  One of: true or false (default).
#
# [*network_connect_db*]
#   Configure SE Linux to allow httpd scripts and modules to connect to
#   databases over the network.  One of: true or false (default).
#
# [*use_nfs*]
#   Configure SE Linux to allow the serving content reached via NFS.  One of:
#   true or false (default).
#
# [*manage_firewall*]
#   If true, open the HTTP port on the firewall.  Otherwise the firewall is
#   left unaffected.  Defaults to true.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2010-2017 John Florian


class apache (
        $anon_write,
        $network_connect,
        $network_connect_db,
        $use_nfs,
        $manage_firewall,
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
        'httpd_use_nfs':
            value => $use_nfs,
            ;
    }

}
