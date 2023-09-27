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

$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/bin")

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

if not (which dotnet | is-empty) {
  $env.PATH = ($env.PATH | split row (char esep) | prepend ~/.dotnet/tools)
}

if not (which sccache  | is-empty) {
  $env.RUSTC_WRAPPER = (which sccache).path
}

$env.DENO_INSTALL = $"($env.HOME)/.deno/bin"
if not (which dvm | is-empty) or ($"($env.DENO_INSTALL)/bin/deno" | path exists) {
  if not ($env.DENO_INSTALL | path exists) {
    mkdir $env.DENO_INSTALL
  }
  $env.PATH = ($env.PATH | split row (char esep) | prepend $env.DENO_INSTALL)
}
hide-env DENO_INSTALL

if ($"($env.HOME)/.krew/bin/kubectl-krew" | path type) == file or ($"($env.HOME)/.krew/bin/kubectl-krew" | path type) == symlink {
  $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.krew/bin")
}

if ($"($env.HOME)/.go/bin/go" | path type) == file {
  $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.go/bin")
  if ($"($env.HOME)/go/bin" | path type) == dir {
    $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/go/bin")
  }
}

$env.DOCKER_BUILDKIT = 1
$env.INPUTRC = $"($env.HOME)/.inputrc"
