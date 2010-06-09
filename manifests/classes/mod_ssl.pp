# /etc/puppet/modules/apache/manifests/classes/mod_ssl.pp

# Synopsis:
#       Include this class in addition to the apache class, if mod_ssl is needed.
#
# Example:
#       include apache
#       include apache::mod_ssl

class apache::mod_ssl {

    package { "mod_ssl":
        ensure  => installed,
    }

    exec { "open-https-port":
        command => "lokkit --port=443:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 443 -j ACCEPT' /etc/sysconfig/iptables",
    }

}
