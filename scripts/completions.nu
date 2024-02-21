if (which carapace | is-empty) {
  return
}
# to update:
# carapace _carapace nushell
# then adapt to this file

mut bridges = []
if $nu.os-info.family == unix {
  $bridges = ($bridges | append 'bash')
}
if not (which inshellisense | is-empty) {
  $bridges = ($bridges | append 'inshellisense')
}
if not ($bridges | is-empty) {
  $env.CARAPACE_BRIDGES = ($bridges | str join ',')
}

# update after this line

def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }

let carapace_completer = {|spans|
  # if the current command is an alias, get it's expansion
  let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)

  # overwrite
  let spans = (if $expanded_alias != null  {
    # put the first word of the expanded alias first in the span
    $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
  } else {
    $spans
  })

  carapace $spans.0 nushell ...$spans
  | from json
}

mut current = (($env | default {} config).config | default {} completions)
$current.completions = ($current.completions | default {} external)
$current.completions.external = ($current.completions.external
| default true enable
| default $carapace_completer completer)

$env.config = $current
