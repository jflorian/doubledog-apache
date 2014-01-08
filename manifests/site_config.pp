# modules/apache/manifests/site_config.pp
#
# == Define: apache::site_config
#
# Installs a site-specific configuration file for the Apache web server.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the site configuration file instance.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the site configuration file.  One and only one of
#   "content" or "source" must be given.
#
# [*source*]
#   URI of the site configuration file content.  One and only one of "content"
#   or "source" must be given.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


define apache::site_config ($ensure='present', $content=undef, $source=undef) {

    include 'apache::params'

    file { "/etc/httpd/conf.d/${name}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        content => $content,
        source  => $source,
        require => Package[$apache::params::packages],
        notify  => Service[$apache::params::services],
    }

}
