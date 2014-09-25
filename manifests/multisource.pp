# firewall::multisource
#
# Hack to allow multiple firewall sources.  It's very much in need of
# expansion, but for now it will get the job done.  (And if we ever get
# multi-source-capable firewall, switch to that immediately!)
#
# Feel free to add more flags to pass through to the firewall flag.
#
# Usage:
#
#   $cms = hiera_array('netrange_cms')
#   firewall::multisource { [ prefix($cms, '050 tftp,') ]:
#     action => 'accept',
#     proto  => 'udp',
#     dport  => '69',
#   }
#
define firewall::multisource (
  $action = 'accept',
  $dport  = undef,
  $sport  = undef,
  $port   = undef,
  $proto  = undef,
  $state  = undef,
  $text   = $title
  ) {
  $value = split ($title, ',')

  firewall { "${value[0]} ${value[1]}":
    action => $action,
    dport  => $dport,
    sport  => $sport,
    proto  => $proto,
    state  => $state,
    port   => $port,
    source => $value[1]
  }
}