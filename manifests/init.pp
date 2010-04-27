# /etc/puppet/modules/apache/manifests/init.pp

class apache {

    include openssl

    package { "httpd":
        ensure  => installed,
    }

    package { "mod_ssl":
        ensure  => installed,
    }

    file { "/etc/httpd/conf/httpd.conf":
        content	=> template("apache/httpd.conf"),
        group   => "root",
        mode    => 640,
        owner   => "root",
        require => Package["httpd"],
    }

    file { "/etc/httpd/conf.d/doubledog.conf":
        group   => "root",
        mode    => 640,
        owner   => "root",
        require => Package["httpd"],
        source  => "puppet:///modules/apache/doubledog.conf",
    }

    file { "/etc/httpd/conf.d/ssl.conf":
        group   => "root",
        mode    => 640,
        owner   => "root",
        require => Package["httpd"],
        source  => "puppet:///modules/apache/ssl.conf",
    }

    openssl::tls-certificate { "doubledog-hector-https":
        cert_source     => "puppet:///private-host/doubledog-hector-http.crt",
        key_source      => "puppet:///private-host/doubledog-hector-http.key",
        notify          => Service["httpd"],
    }

    # Web content is reached via NFS, so selinux must be adjusted to allow the
    # apache daemon to access it.
    exec { "allow-httpd-use-nfs":
        command => "setsebool -P httpd_use_nfs on",
        unless  => "getsebool httpd_use_nfs | grep -q -- 'on$'",
    }

    exec { "open-http-port":
        command => "lokkit --port=80:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables",
    }

    exec { "open-https-port":
        command => "lokkit --port=443:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 443 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "httpd":
        enable          => true,
        ensure          => running,
        hasrestart      => true,
        hasstatus       => true,
        require         => [
            Exec["allow-httpd-use-nfs"],
            Exec["open-http-port"],
            Exec["open-https-port"],
            Package["httpd"],
            Package["mod_ssl"],
        ],
        subscribe       => [
            File["/etc/httpd/conf.d/doubledog.conf"],
            File["/etc/httpd/conf.d/ssl.conf"],
        ],
    }

}
