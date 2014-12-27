# modules/apache/manifests/params.pp
#
# == Class: apache::params
#
# Parameters for the apache puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class apache::params {

    case $::operatingsystem {

        Fedora: {

            $packages = [
                'httpd',
            ]
            $modpassenger_packages = [
                'mod_passenger',
            ]
            $modssl_packages = [
                'mod_ssl',
            ]
            $services = [
                'httpd',
            ]

            if $::operatingsystemrelease < 18 {
                $bool_anon_write = 'allow_httpd_anon_write'
            } else {
                $bool_anon_write = 'httpd_anon_write'
            }
            $bool_can_network_connect = 'httpd_can_network_connect'
            $bool_can_network_connect_db = 'httpd_can_network_connect_db'
            $bool_use_nfs = 'httpd_use_nfs'


        }

        default: {
            fail ("The apache module is not yet supported on ${::operatingsystem}.")
        }

    }

}
