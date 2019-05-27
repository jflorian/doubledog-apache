#
# == Class: apache::mod_info
#
# Configures the Apache server status page.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later

class apache::mod_info (
    Array[String]   $allow_from_host,
    Array[String]   $allow_from_ip,
    String[1]       $location,
    ) {

    include 'apache'

    file { '/etc/httpd/conf.d/mod_info.conf':
        content => template('apache/mod_info.conf.erb'),
        notify  => Class['apache::service'],
        require => Class['apache::package'],
    }

}
