# modules/apache/manifests/module_config.pp
#
# == Define: apache::module_config
#
# Manages a module configuration file for the Apache HTTP server.
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
#   Instance is to be 'present' (default) or 'absent'.
#
# [*filename*]
#   Name to be given to the configuration file, without any path details nor
#   ".conf" suffix.  E.g., "99-prefork".  This may be used in place of
#   "namevar" if it's beneficial to give namevar an arbitrary value.
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
# Copyright 2014-2015 John Florian


define apache::module_config (
        $ensure='present',
        $filename=$title,
        $source=undef,
        $content=undef,
    ) {

    include '::apache::params'

    file { "/etc/httpd/conf.modules.d/${filename}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        source  => $source,
        content => $content,
        require => Package[$::apache::params::packages],
        before  => Service[$::apache::params::services],
        notify  => Service[$::apache::params::services],
    }

}
