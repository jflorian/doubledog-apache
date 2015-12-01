# modules/apache/manifests/params.pp
#
# == Class: apache::params
#
# Parameters for the apache puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2015 John Florian


class apache::params {

    case $::operatingsystem {

        'Fedora': {

            $packages = 'httpd'
            $modpassenger_packages = 'mod_passenger'
            $modssl_packages = 'mod_ssl'
            $services = 'httpd'

            $bool_anon_write = 'httpd_anon_write'
            $bool_can_network_connect = 'httpd_can_network_connect'
            $bool_can_network_connect_db = 'httpd_can_network_connect_db'
            $bool_use_nfs = 'httpd_use_nfs'


        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
