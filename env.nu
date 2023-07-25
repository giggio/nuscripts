# Nushell Environment Config File
#
# version = 0.80.1

use std

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let configPath = ($nu.config-path | path dirname)
let scriptsPath = ($configPath | path join scripts)
let-env NU_LIB_DIRS = [
    ($nu.default-config-dir | path join scripts)
    $scriptsPath
    ($configPath | path join scripts | path join dynamic)
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join plugins)
    ($configPath | path join plugins)
]

if $nu.os-info.family == windows and (($env | get -i HOME) == null) {
  let-env HOME = $env.USERPROFILE
}
let binDir = ($env.HOME | path join bin)
if ($binDir | path type) == dir {
  std path add $binDir
}

if ($nu.os-info.family == unix) {
  let-env PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")
}

if ($nu.os-info.family == unix) {
  let N_PREFIX = ($env.HOME | path join .n)
  if ($N_PREFIX | path type) == dir {
    let-env PATH = ($env.PATH | split row (char esep) | prepend ($N_PREFIX | path join bin))
    let-env N_PREFIX = $N_PREFIX
  }
}

if ($nu.os-info.family == unix) {
  let-env RUNNING_IN_CONTAINER = (('/.dockerenv' | path type) == 'file' or (grep docker /proc/1/cgroup -qa err> /dev/null | complete).exit_code == 0)
  let-env WSL = (grep microsoft /proc/version -q | complete).exit_code == 0
} else {
  let-env RUNNING_IN_CONTAINER = false
  let-env WSL = false
}

if ($env | get -i EDITOR) == null {
  let-env EDITOR = vim
}
if ($env | get -i VISUAL) == null {
  let-env VISUAL = vim
}
