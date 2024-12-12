let bashscripts = ($NUSHELL_CONFIG_DIR | path join .. bashscripts | path expand)
if ($bashscripts | path exists) {
  let bashrcwsl = ($bashscripts | path join "bashrc-wsl.bash")
  if ($bashrcwsl | path exists) {
    do {
      ^$bashrcwsl
    }
  }
}
$env.SSH_AUTH_SOCK = ($env.XDG_RUNTIME_DIR | path join 'gnupg/ssh.sock')
