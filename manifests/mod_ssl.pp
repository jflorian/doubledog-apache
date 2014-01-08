# modules/apache/manifests/mod_ssl.pp
#
# == Class: apache::mod_ssl
#
# Configures the Apache web server to provide mod_ssl (HTTPS) support.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class apache::mod_ssl {

    package { $apache::params::modssl_packages:
        ensure  => installed,
        notify  => Service[$apache::params::services],
    }

    iptables::tcp_port {
        'https':    port => '443';
    }

}
