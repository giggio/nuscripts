source (if $WSL { 'config-wsl.nu' } else { 'noop.nu' })
source alias-linux.nu

let gpg_ssh_auth_sock = $"($env.XDG_RUNTIME_DIR)/gnupg/S.gpg-agent.ssh"
if ($gpg_ssh_auth_sock | path exists) {
  $env.SSH_AUTH_SOCK = $gpg_ssh_auth_sock
} else {
  let pid_file = $env.HOME/.ssh/ssh_pid
  let ssh_auth_sock = $env.HOME/.ssh/ssh.sock
  if ($ssh_auth_sock | path exists) {
    $env.SSH_AUTH_SOCK = $ssh_auth_sock
    if ($pid_file | path exists) {
      $env.SSH_AGENT_PID = ($pid_file | open --raw)
    }
  } else {
    let ssh_dir = $env.HOME/.ssh
    if !($ssh_dir | path exists) {
      mkdir $ssh_dir
      chmod 700 $ssh_dir
    }
    ^ssh-agent -c -a $ssh_auth_sock | lines | first 2 | parse "setenv {name} {value};" | transpose -r | into record | load-env
  }
}
