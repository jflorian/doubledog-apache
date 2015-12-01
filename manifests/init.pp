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
# Copyright 2010-2015 John Florian


class apache (
        $anon_write=false,
        $network_connect=false,
        $network_connect_db=false,
        $use_nfs=false,
        $manage_firewall=true,
    ) inherits ::apache::params {

    include '::apache::package'
    include '::apache::service'

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'httpd_config_t',
        before    => Service[$::apache::params::services],
        notify    => Service[$::apache::params::services],
        subscribe => Package[$::apache::params::packages],
    }

    file { '/etc/httpd/conf/httpd.conf':
        content  => template("apache/httpd.conf.${::operatingsystem}.${::operatingsystemrelease}"),
    }

    if $manage_firewall {
        firewall { '500 accept HTTP packets':
            dport  => '80',
            proto  => 'tcp',
            state  => 'NEW',
            action => 'accept',
        }
    }

    Selinux::Boolean {
        before     => Service[$::apache::params::services],
        persistent => true,
    }

    selinux::boolean {
        $::apache::params::bool_anon_write:
            value => $anon_write;

        $::apache::params::bool_can_network_connect:
            value => $network_connect;

        $::apache::params::bool_can_network_connect_db:
            value => $network_connect_db;

        $::apache::params::bool_use_nfs:
            value => $use_nfs;
    }

}
