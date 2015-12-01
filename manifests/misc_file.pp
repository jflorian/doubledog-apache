# modules/apache/manifests/misc_file.pp
#
# == Define: apache::misc_file
#
# Manages a miscellaneous file for the Apache web server.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   An arbitrary identifier for the file instance unless the "filename"
#   parameter is not set in which case this must provide the value normally
#   set with the "filename" parameter.
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*filename*]
#   Name to be given to the file, without any path details.  This may be used
#   in place of "namevar" if it's beneficial to give namevar an arbitrary
#   value.
#
# [*content*]
#   Literal content for the file.  If neither "content" nor "source" is given,
#   the content of the file will be left unmanaged.
#
# [*source*]
#   URI of the file content.  If neither "content" nor "source" is given, the
#   content of the file will be left unmanaged.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2015 John Florian


define apache::misc_file (
        $ensure='present',
        $filename=$title,
        $content=undef,
        $source=undef,
        $owner='root',
        $group='apache',
        $mode='0640',
    ) {

    include '::apache::params'

    file { "/etc/httpd/${filename}":
        ensure  => $ensure,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        content => $content,
        source  => $source,
        require => Package[$::apache::params::packages],
        notify  => Service[$::apache::params::services],
    }

}
