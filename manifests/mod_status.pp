# modules/apache/manifests/mod_status.pp
#
# == Class: apache::mod_status
#
# Configures the Apache server status page.
#
# === Parameters
#
#  [*location*]
#  This parameter controls the location used to access the apache status page.  Default value is set to /server-status.
#
#  [*allow_from*]
#  This parameter controls what IPs or IP ranges are allowed to access the apache status page.
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2017-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later

class apache::mod_status (
    String[1] $location,
    Array[String] $allow_from,
    ) {

    include 'apache'

    file { '/etc/httpd/conf.d/mod_status.conf':
        content => template('apache/mod_status.conf.erb'),
        notify  => Class['apache::service'],
        require => Class['apache::package'],
    }

}
