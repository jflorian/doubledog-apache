#
# == Define: apache::module_config
#
# Manages a module configuration file for the Apache web server.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2014-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define apache::module_config (
        Ddolib::File::Ensure    $ensure='present',
        Optional[String[1]]     $content=undef,
        String[1]               $filename=$title,
        String[1]               $group='apache',
        Pattern[/[0-7]{4}/]     $mode='0640',
        String[1]               $owner='root',
        Optional[String[1]]     $source=undef,
    ) {

    file { "/etc/httpd/conf.modules.d/${filename}.conf":
        ensure  => $ensure,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        content => $content,
        source  => $source,
        require => Class['::apache::package'],
        before  => Class['::apache::service'],
        notify  => Class['::apache::service'],
    }

}
