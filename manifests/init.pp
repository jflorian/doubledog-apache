# /etc/puppet/modules/apache/manifests/init.pp

class apache {

    package { "httpd":
	ensure	=> installed,
    }

#   # static file
#   file { "/CONFIG_PATH/CONFIG_NAME":
#       # don't forget to verify these!
#       group	=> "root",
#       mode    => 640,
#       owner   => "root",
#       require => Package["httpd"],
#       source  => "puppet:///modules/apache/CONFIG_NAME",
#   }

#   # template file
#   file { "/CONFIG_PATH/CONFIG_NAME":
#       content	=> template("apache/CONFIG_NAME"),
#       # don't forget to verify these!
#       group	=> "root",
#       mode    => 640,
#       owner   => "root",
#       require => Package["httpd"],
#   }

    exec { "open-httpd-ports":
        command => "lokkit --port=80:tcp --port=443:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables &&
                    grep -q -- '-A INPUT .* -p tcp --dport 443 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "httpd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-httpd-ports"],
            Package["httpd"],
        ],
#       subscribe	=> [
#           File["/CONFIG_PATH/CONFIG_NAME"],
#       ],
    }

}
