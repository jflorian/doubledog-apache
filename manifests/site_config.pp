# modules/apache/manifests/site_config.pp
#
# == Define: apache::site_config
#
# Manages a site-specific configuration file for the Apache web server.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   An arbitrary identifier for the configuration file instance unless the
#   "filename" parameter is not set in which case this must provide the value
#   normally set with the "filename" parameter.
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.  Alternatively,
#   a Boolean value may also be used with true equivalent to 'present' and
#   false equivalent to 'absent'.
#
# [*filename*]
#   Name to be given to the configuration file, without any path details.
#   This may be used in place of "namevar" if it's beneficial to give namevar
#   an arbitrary value.
#
# [*content*]
#   Literal content for the configuration file.  If neither "content" nor
#   "source" is given, the content of the file will be left unmanaged.
#
# [*source*]
#   URI of the configuration file content.  If neither "content" nor "source"
#   is given, the content of the file will be left unmanaged.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2017 John Florian


define apache::site_config (
        Variant[Boolean, Enum['present', 'absent']] $ensure='present',
        Optional[String[1]]     $content=undef,
        String[1]               $filename=$title,
        Optional[String[1]]     $source=undef,
    ) {

    file { "/etc/httpd/conf.d/${filename}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        content => $content,
        source  => $source,
        require => Class['::apache::package'],
        notify  => Class['::apache::service'],
    }

}
