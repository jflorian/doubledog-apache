<!--
This file is part of the doubledog-apache Puppet module.
Copyright 2018-2020 John Florian
SPDX-License-Identifier: GPL-3.0-or-later

Template

## [VERSION] WIP
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

-->

# Change log

All notable changes to this project (since v3.0.0) will be documented in this file.  The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [3.4.0] WIP
### Added
- initial FreeBSD support
### Changed
### Deprecated
### Removed
### Fixed
### Security

## [3.3.0] 2020-01-02
### Added
- Fedora 31 support
- CentOS 8 support
### Changed
- dependency on `puppetlabs/firewall` now allows version 2
- dependency on `puppet/selinux` now allows version 3
### Removed
- Fedora 28 support
### Fixed
- SELinux failures with older Puppet agents

## [3.2.0] 2019-05-27
### Added
- `apache::mod_info` class
- `apache::mod_status` class
### Fixed
- errors occur when SELinux is disabled

## [3.1.0] 2019-05-02
### Added
- Fedora 29 support
- Fedora 30 support
### Changed
- dependency on `doubledog/ddolib` now expects 1 >= version < 2
- Absolute namespace references have been eliminated since modern Puppet versions no longer require this.
### Removed
- Fedora 26 support
- Fedora 27 support

## [3.0.0 and prior] 2018-12-15

This and prior releases predate this project's keeping of a formal CHANGELOG.  If you are truly curious, see the Git history.
