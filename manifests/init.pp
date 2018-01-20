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
#   file transfer services.  One of: true or false (default).
#
# [*log_level*]
#   Controls the number of messages logged to the error_log.  Possible values
#   include: debug, info, notice, warn, error, crit, alert, emerg.  The
#   default is warn.
#
# [*manage_firewall*]
#   If true, open the HTTP port on the firewall.  Otherwise the firewall is
#   left unaffected.  Defaults to true.
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
#
# === Copyright
#
# Copyright 2010-2018 John Florian


class apache (
        Boolean             $anon_write,
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
        'httpd_use_nfs':
            value => $use_nfs,
            ;
    }

}
