if $nu.os-info.family != windows {
  return
}

$env.RUNNING_IN_CONTAINER = false
$env.WSL = false

if ($env | get -i HOME) == null {
  $env.HOME = $env.USERPROFILE
}

def "path get" [] {
  $env.Path
}
