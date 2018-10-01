#
# == Type: apache::log_level
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-apache Puppet module.
# Copyright 2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


type Apache::Log_level = Enum[
    'emerg',
    'alert',
    'crit',
    'error',
    'warn',
    'notice',
    'info',
    'debug',
]
