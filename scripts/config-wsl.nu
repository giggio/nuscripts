if not ($env | get -i WSL | default false) {
  return
}
let bashscripts = ($nu.config-path | path dirname | path join .. bashscripts | path expand)
if ($bashscripts | path exists) {
  let bashrcwsl = ($bashscripts | path join "bashrc-wsl.bash")
  if ($bashrcwsl | path exists) {
    ^$bashrcwsl
  }
}
let SSH_AUTH_SOCK = /tmp/ssh_agent_socket
let-env SSH_AUTH_SOCK = if ($SSH_AUTH_SOCK | path exists) {
  $SSH_AUTH_SOCK
}