if (which carapace | is-empty) {
  return
}
# to update: carapace _carapace nushell | save --force completions.nu

let carapace_completer = {|spans|
  carapace $spans.0 nushell $spans | from json
}

mut current = (($env | default {} config).config | default {} completions)
$current.completions = ($current.completions | default {} external)
$current.completions.external = ($current.completions.external
    | default true enable
    | default $carapace_completer completer)

let-env config = $current
