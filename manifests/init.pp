# modules/apache/manifests/init.pp
#
# == Class: apache
#
# Configures a host to provide an Apache web server.
#
# === Parameters
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
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class apache (
        $anon_write=false, $network_connect=false, $network_connect_db=false,
        $use_nfs=false
    ) {

    include 'apache::params'

    package { $apache::params::packages:
        ensure  => installed,
        notify  => Service[$apache::params::services],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'httpd_config_t',
        before      => Service[$apache::params::services],
        notify      => Service[$apache::params::services],
        subscribe   => Package[$apache::params::packages],
    }

    file { '/etc/httpd/conf/httpd.conf':
        content	=> template("apache/httpd.conf.${operatingsystem}.${operatingsystemrelease}"),
    }

    iptables::tcp_port {
        'http': port => '80';
    }

    Selinux::Boolean {
        persistent  => true,
        before      => Service[$apache::params::services],
    }

    selinux::boolean {
        $apache::params::bool_anon_write:
            value       => $anon_write ? {
                true    => 'on',
                default => 'off',
            };
        $apache::params::bool_can_network_connect:
            value       => $network_connect ? {
                true    => 'on',
                default => 'off',
            };
        $apache::params::bool_can_network_connect_db:
            value       => $network_connect_db ? {
                true    => 'on',
                default => 'off',
            };
        $apache::params::bool_use_nfs:
            value       => $use_nfs ? {
                true    => 'on',
                default => 'off',
            };
    }

    service { $apache::params::services:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
