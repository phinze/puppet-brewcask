class brewcask {
  require homebrew

  homebrew::tap { 'caskroom/cask': }

  package { 'brew-cask':
    require => Homebrew::Tap['caskroom/cask']
  }
}
