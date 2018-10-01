#
# == Class: apache::service
#
# Manages the Apache web server service.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2015-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class apache::service (
        Ddolib::Service::Ensure $ensure,
        String[1]               $daemon,
        Boolean                 $enable,
    ) {

    service { $daemon:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
