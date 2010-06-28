# /etc/puppet/modules/apache/manifests/init.pp

class apache {

    include openssl

    package { "httpd":
        ensure  => installed,
    }

    file { "/etc/httpd/conf/httpd.conf":
        content	=> template("apache/httpd.conf"),
        group   => "root",
        mode    => "0640",
        owner   => "root",
        require => Package["httpd"],
    }

    # Web content is reached via NFS, so selinux must be adjusted to allow the apache daemon to access it.
    selboolean { "httpd_use_nfs":
        persistent      => true,
        value           => on,
    }

    exec { "open-http-port":
        command => "lokkit --port=80:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "httpd":
        enable          => true,
        ensure          => running,
        hasrestart      => true,
        hasstatus       => true,
        require         => [
            Exec["open-http-port"],
            Package["httpd"],
            Selboolean["httpd_use_nfs"],
        ],
        subscribe       => [
            File["/etc/httpd/conf/httpd.conf"],
        ],
    }

}
