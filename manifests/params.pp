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
            $modssl_packages = [
                'mod_ssl',
            ]
            $services = [
                'httpd',
            ]

        }

        default: {
            fail ("The apache module is not yet supported on $::operatingsystem.")
        }

    }

}
