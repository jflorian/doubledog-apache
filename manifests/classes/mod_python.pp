# modules/apache/manifests/classes/mod_python.pp

# Synopsis:
#       Include this class in addition to the apache class, if mod_python is needed.
#
# Example:
#       include apache
#       include apache::mod_python

class apache::mod_python {

    package { "mod_python":
        ensure  => installed,
    }

}
