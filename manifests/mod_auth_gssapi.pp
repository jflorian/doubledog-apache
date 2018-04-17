#
# == Class: apache::mod_auth_gssapi
#
# Manages the Apache web server to provide authorization via Kerberos using
# only GSSAPI calls.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class apache::mod_auth_gssapi (
        Optional[String[1]]     $keytab_content,
        Optional[String[1]]     $keytab_source,
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
        notify => Class['::apache::service'],
    }

    ::apache::misc_file { 'conf/http.keytab':
        content => $keytab_content,
        source  => $keytab_source,
    }

}
