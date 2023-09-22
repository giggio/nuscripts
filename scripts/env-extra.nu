use std

let configPath = $nu.config-path | path dirname
let scriptsPath = $configPath | path join scripts

$env.NU_PLUGIN_DIRS = [
  ($configPath | path join plugins)
]

if $nu.os-info.family == windows and (($env | get -i HOME) == null) {
  $env.HOME = $env.USERPROFILE
}
let binDir = $env.HOME | path join bin
if ($binDir | path type) == dir {
  std path add $binDir
}

if ($nu.os-info.family == unix) {
  $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")
}

if ($nu.os-info.family == unix) {
  let N_PREFIX = $env.HOME | path join .n
  if ($N_PREFIX | path type) == dir {
    $env.PATH = ($env.PATH | split row (char esep) | prepend ($N_PREFIX | path join bin))
    $env.N_PREFIX = $N_PREFIX
  }
}

if ($nu.os-info.family == unix) {
  $env.RUNNING_IN_CONTAINER = (('/.dockerenv' | path type) == 'file' or (grep docker /proc/1/cgroup -qa err> /dev/null | complete).exit_code == 0)
  $env.WSL = (grep microsoft /proc/version -q | complete).exit_code == 0
} else {
  $env.RUNNING_IN_CONTAINER = false
  $env.WSL = false
}

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
  $env.PATH = ($env.PATH | split row (char esep) | prepend ~/.fzf/bin)

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
