if (which carapace | is-empty) {
  return
}
# to update: carapace _carapace nushell | save --force completions.nu

let carapace_completer = {|spans|
  carapace $spans.0 nushell $spans | from json
}

let aliasedCommands = scope aliases | where expansion !~ '\^' | select name expansion | insert command { |row| ( $row.expansion | parse --regex '(?P<command>\w+).*' | get 0 | get command ) } | select name command
let alias_completer = { |spans|
  mut $completions = (do $carapace_completer $spans)
  if ($completions | is-empty) {
    let unaliasedCommand = $aliasedCommands | where name == $spans.0 | get -i 0 | get -i command
    if ($unaliasedCommand != null) {
      mut mutSpans = $spans
      $mutSpans.0 = $unaliasedCommand
      $completions = (do $carapace_completer $mutSpans)
    }
  }
  $completions
}

mut current = (($env | default {} config).config | default {} completions)
$current.completions = ($current.completions | default {} external)
$current.completions.external = ($current.completions.external
  | default true enable
  | default $alias_completer completer)

$env.config = $current
