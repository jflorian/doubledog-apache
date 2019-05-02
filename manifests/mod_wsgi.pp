#
# == Class: apache::mod_wsgi
#
# Manages the Apache web server to provide the Web Server Gateway Interface.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2017-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class apache::mod_wsgi (
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
        notify => Class['apache::service'],
    }

}
