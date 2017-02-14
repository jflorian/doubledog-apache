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
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.  Alternatively,
#   a Boolean value may also be used with true equivalent to 'running' and
#   false equivalent to 'stopped'.
#
# [*daemon*]
#   The service name of the Apache HTTP daemon.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2015-2017 John Florian


class apache::service (
        Variant[Boolean, Enum['running', 'stopped']] $ensure,
        Boolean                 $enable,
        String[1]               $daemon,
    ) {

    service { $daemon:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
