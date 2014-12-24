# Public: Install and configure brewcask for use with Boxen.
#
# Examples
#
#   include brewcask

class brewcask {

  include homebrew

  file {
    [$::brewcask_root, "${brewcask_root}/bin", "${brewcask_root}/Caskroom"]:
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
