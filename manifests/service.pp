# modules/apache/manifests/service.pp
#
# == Class: apache::service
#
# Manages the Apache web server service.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2015-2016 John Florian


class apache::service (
    ) inherits ::apache::params {

    service { $::apache::params::services:
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
    }

}
