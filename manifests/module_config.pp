# modules/apache/manifests/module_config.pp
#
# == Define: apache::module_config
#
# Installs a module configuration file for the Apache HTTP server.
#
# === Parameters
#
# [*namevar*]
#   Instance name, e.g., "99-prefork".  Include neither path, nor '.conf'
#   extension.  These typically have a two-digit prefix for priority
#   sequencing.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the module_config file.  One and only one of "content"
#   or "source" must be given.
#
# [*source*]
#   URI of the module_config file content.  One and only one of "content" or
#   "source" must be given.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define apache::module_config (
        $ensure='present', $source=undef, $content=undef
    ) {

    include 'apache::params'

    file { "/etc/httpd/conf.modules.d/${name}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        source  => $source,
        content => $content,
        require => Package[$apache::params::packages],
        before  => Service[$apache::params::services],
        notify  => Service[$apache::params::services],
    }

}
