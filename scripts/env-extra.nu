use std

let configPath = $nu.config-path | path dirname
let scriptsPath = $configPath | path join scripts

$env.NU_PLUGIN_DIRS = [
  ($configPath | path join plugins)
]

if $nu.os-info.family == windows {
  source env-extra-windows.nu
}

if ($nu.os-info.family == unix) {
  source env-extra-linux.nu
}

$env.binDir = ($env.HOME | path join bin)
if ($env.binDir | path type) == dir {
  std path add $env.binDir
}
hide-env binDir

if ($env | get -i EDITOR) == null {
  $env.EDITOR = vim
}
if ($env | get -i VISUAL) == null {
  $env.VISUAL = vim
}

if ('~/.kube' | path exists) {
  $env.KUBECONFIG = (ls ~/.kube | where type == file and name !~ '.*\.ba(k|ckup)' and name != kubectx | sort | get name | str join (char esep))
}

if ('~/.fzf' | path exists) {
  std path add ~/.fzf/bin

  # todo: add completions and key bindings, but currently there is no scripts for Nushell. Something like:
  # if ($nu.is-interactive) {
  #   source ~/.fzf/shell/completion.nu 2> /dev/null
  #   source ~/.fzf/shell/key-bindings.nu
  # }

  if not (which fd | is-empty) {
    $env.FZF_DEFAULT_COMMAND = "fd --type file --color=always --exclude .git"
    $env.FZF_DEFAULT_OPTS = "--ansi"
    $env.FZF_CTRL_T_COMMAND = $env.FZF_DEFAULT_COMMAND
  }
}

if not (which dotnet | is-empty) {
  std path add $"($env.HOME)/.dotnet/tools"
}

if not (which sccache | is-empty) {
  $env.RUSTC_WRAPPER = (which sccache).path
}

