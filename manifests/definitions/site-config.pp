/*
== Definition: apache::site-config

Installs a web-site configuration file for the Apache web server.

Parameters:
- *name*:       The name of the web site.
- *source*:     The puppet URI for obtaining the web site's configuration file.

Requires:
- Class["apache"]

Example usage:

    include apache

    apache::site-config { "acme":
        notify  => Service["httpd"],
        source  => "puppet:///private-host/acme.conf",
    }

*/

define apache::site-config ($ensure="present", $source) {

    file { "/etc/httpd/conf.d/${name}.conf":
        ensure  => $ensure,
        owner   => "root",
        group   => "root",
        mode    => "0640",
        seluser => "system_u",
        selrole => "object_r",
        seltype => "httpd_config_t",
        require => Package["httpd"],
        source  => "${source}",
    }

}
