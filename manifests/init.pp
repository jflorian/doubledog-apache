# modules/apache/manifests/init.pp
#
# == Class: apache
#
# Configures a host to provide an Apache web server.
#
# === Parameters
#
# [*use_nfs*]
#   Configure SE Linux to allow the serving content reached via NFS.  One of:
#   true or false (default).
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class apache ($use_nfs=false) {

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

    selinux::boolean { 'httpd_use_nfs':
        persistent  => true,
        value       => $use_nfs ? {
            true    => 'on',
            default => 'off',
        },
        before      => Service[$apache::params::services],
    }

    service { $apache::params::services:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
