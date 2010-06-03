/*
== Definition: apache::bind-mount

Bind mounts a directory structure under the standard DocumentRoot so as to
comply with SE Linux policy.

Parameters:
- *name*:       The directory name to be populated under /var/www.
- *source*:     The directory name to be bind mounted at *name*.

Requires:
- Class["apache"]

Example usage:

    include apache

    apache::bind-mount { "html":
        source  => "/mnt/resources/www/html/",
    }

*/

define apache::bind-mount ($ensure="mounted", $source) {

    file { "/var/www/${name}":
        ensure  => directory,
# These are disabled because they cause puppet failure once the mount is in
# effect.  This is probably a bug that should be reported since 'replace' is
# of no help here.
#       owner   => "root",
#       group   => "root",
#       mode    => "0755",
        replace => false,
        seluser => "system_u",
        selrole => "object_r",
        seltype => "httpd_sys_content_t",
        require => Package["httpd"],
    }

    mount { "/var/www/${name}":
        atboot  => true,
        before  => Service["httpd"],
        device  => $source,
        ensure  => $ensure,
        fstype  => "none",
        options => "bind,_netdev",
        require => File["/var/www/${name}"],
    }


}
