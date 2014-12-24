# Public: Install and configure brewcask for use with Boxen.
#
# Examples
#
#   include brewcask

class brewcask(
  $installdir = $brewcask::config::installdir,
  $caskroom   = $brewcask::config::caskroom,
) inherits brewcask::config {

  include homebrew

  file {
    [$installdir, $caskroom]:
      ensure  => 'directory',
      owner   => $::boxen_user,
      group   => 'staff',
      mode    => '0755',
  }

  homebrew::tap { 'caskroom/cask':
    before => Package['brew-cask'],
  }

  package { 'brew-cask':
    provider => homebrew,
  }

  boxen::env_script { 'brewcask':
    content  => template('brewcask/env.sh.erb'),
    priority => highest,
  }

  Package['brew-cask'] -> Package <| provider == brewcask |>
}
