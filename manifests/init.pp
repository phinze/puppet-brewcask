# Public: Install and configure brewcask for use with Boxen.
#
# Examples
#
#   include brewcask

class brewcask(
  $installdir = $brewcask::config::installdir,
  $caskroom   = $brewcask::config::caskroom,
  $appdir     = $brewcask::config::appdir,
  $binarydir  = $brewcask::config::binarydir,
) inherits brewcask::config {

  include homebrew

  file {
    [$installdir, "${installdir}/bin", $caskroom]:
      ensure  => 'directory',
      owner   => $::boxen_user,
      group   => 'staff',
      mode    => '0755',
  }

  homebrew::tap { 'caskroom/cask':
    before => Package['brew-cask'],
  }

  package { 'brew-cask':
    ensure   => 'latest',
    provider => homebrew,
  }

  boxen::env_script { 'brewcask':
    content  => template('brewcask/env.sh.erb'),
    priority => highest,
  }

  Package['brew-cask'] -> Package <| provider == brewcask |>
}
