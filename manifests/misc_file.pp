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
#   Instance is to be 'present' (default) or 'absent'.  Alternatively,
#   a Boolean value may also be used with true equivalent to 'present' and
#   false equivalent to 'absent'.
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
# Copyright 2014-2017 John Florian


define apache::misc_file (
        Variant[Boolean, Enum['present', 'absent']] $ensure='present',
        Optional[String[1]]     $content=undef,
        String[1]               $filename=$title,
        String[1]               $group='apache',
        Pattern[/[0-7]{4}/]     $mode='0640',
        String[1]               $owner='root',
        Optional[String[1]]     $source=undef,
    ) {

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
        require => Class['::apache::package'],
        notify  => Class['::apache::service'],
    }

}
