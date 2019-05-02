#
# == Class: apache::package
#
# Manages the minimal Apache web server packages.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2015-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class apache::package (
        Array[String[1], 1]     $names,
    ) {

    package { $names:
        ensure => installed,
        notify => Class['apache::service'],
    }

}
