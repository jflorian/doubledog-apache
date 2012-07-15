# modules/apache/manifests/mod_ssl.pp

# Synopsis:
#       Include this class in addition to the apache class, if mod_ssl is needed.
#
# Example:
#       include apache
#       include apache::mod_ssl

class apache::mod_ssl {

    include lokkit

    package { "mod_ssl":
        ensure  => installed,
    }

    lokkit::tcp_port { "https":
        port    => "443",
    }

}
