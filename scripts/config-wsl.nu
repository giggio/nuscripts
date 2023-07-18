if not $env.WSL {
  return
}
let SSH_AUTH_SOCK = /tmp/ssh_agent_socket
let-env SSH_AUTH_SOCK = if ($SSH_AUTH_SOCK | path exists) {
  $SSH_AUTH_SOCK
}
