# Public: Variables for working with brewcask
#
# Examples
#
#   require brewcask::config

class brewcask::config {
  $installdir = $::brewcask_root
  $caskroom   = "${installdir}/Caskroom"
  $appdir     = '/Applications'
  $binarydir  = "${installdir}/bin"
}
