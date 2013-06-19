# Class: postgresql::devel
#
#   This class installs postgresql development libraries
#
# Parameters:
#   [*package_name*]   - The name of the postgresql development package.
#   [*package_ensure*] - The ensure value of the package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class postgresql::devel(
  $package_name   = $postgresql::params::devel_package_name,
  $package_ensure = 'present'
) inherits postgresql::params {

  validate_string($package_name)

  package { 'postgresql-devel':
    ensure => $package_ensure,
    name   => $package_name,
    tag    => 'postgresql',
  }

  if $::osfamily == 'Debian' {
    # Debian packages separate their front/backend C libraries...
    package { "postgresql-server-dev-${postgresql::params::version}":
      ensure  => $package_ensure,
      require => Package['postgresql-devel'],
    }
  }
}
