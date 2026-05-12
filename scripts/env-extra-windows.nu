$env.RUNNING_IN_CONTAINER = false
$env.WSL = false

if ($env | get -o HOME) == null {
  $env.HOME = $env.USERPROFILE
}
