# == Class: apache::mod_auth_gssapi
#
# Manages the Apache web server to provide authorization via Kerberos using
# only GSSAPI calls.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*keytab_content*]
#   Literal content for the Kerberos keytab file.  If neither "content" nor
#   "source" is given, the content of the file will be left unmanaged.
#
# [*keytab_source*]
#   URI of the Kerberos keytab file content.  If neither "content" nor
#   "source" is given, the content of the file will be left unmanaged.
#
# [*packages*]
#   An array of package names needed for the Apache web server with Kerberos
#   installation.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2018 John Florian


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
