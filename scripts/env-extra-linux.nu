$env.RUNNING_IN_CONTAINER = ((('/.dockerenv' | path exists) and ('/.dockerenv' | path type) == 'file') or (grep docker /proc/1/cgroup -qa err> /dev/null | complete).exit_code == 0)
$env.WSL = (grep microsoft /proc/version -q | complete).exit_code == 0

source (if $WSL { 'env-wsl.nu' } else { 'noop.nu' })
source nix.nu

std path add $"($env.HOME)/.local/bin"

$env.TMP = "/tmp"
$env.TEMP = "/tmp"

if ($"($env.HOME)/.cargo/bin" | path exists) and ($"($env.HOME)/.cargo/bin" | path type) == dir {
  std path add $"($env.HOME)/.cargo/bin"
}

let DENO_INSTALL = $"($env.HOME)/.deno/bin"
if (which dvm | is-not-empty) or ($"($DENO_INSTALL)/bin/deno" | path exists) {
  if not ($DENO_INSTALL | path exists) {
    mkdir $DENO_INSTALL
  }
  std path add $DENO_INSTALL
}

if ($"($env.HOME)/.krew/bin/kubectl-krew" | path exists) and (($"($env.HOME)/.krew/bin/kubectl-krew" | path type) == file or ($"($env.HOME)/.krew/bin/kubectl-krew" | path type) == symlink) {
  std path add $"($env.HOME)/.krew/bin"
}

if ($"($env.HOME)/.go/bin/go" | path exists) and ($"($env.HOME)/.go/bin/go" | path type) == file {
  std path add $"($env.HOME)/.go/bin"
  if ($"($env.HOME)/go/bin" | path exists) and ($"($env.HOME)/go/bin" | path type) == dir {
    std path add $"($env.HOME)/go/bin"
  }
}

$env.DOCKER_BUILDKIT = 1
$env.INPUTRC = $"($env.HOME)/.inputrc"

