if (which navi | is-empty) {
  return
}

def _navi_call [] {
  let result = navi --print
  if $result == "" {
    return
  }
  let tmpfile = mktemp --tmpdir --suffix .nu
  print $result
  try {
    $result | save --force $tmpfile
    history insert $result
    nu $tmpfile
  } catch { |e|
    use std log
    log error $"Command failed: ($e)"
  }
  rm $tmpfile
  ignore
}

# use dotfiles cheats if it exists
let cheats_dir = ($nu.config-path | path dirname | path join .. cheats | path expand)
if ($cheats_dir | path exists) {
  let os = if $nu.os-info.family == unix { 'linux' } else { 'windows' }
  $env.NAVI_PATH = $"($cheats_dir)/dist/common/(char esep)($cheats_dir)/dist/nushell/(char esep)($cheats_dir)/dist/($os)/common/(char esep)($cheats_dir)/dist/($os)/nushell/"
}

$env.config.keybindings = ($env.config.keybindings | append {
  name: navi
  modifier: control
  keycode: char_g
  mode: [emacs vi_normal vi_insert]
  event: {
    send: ExecuteHostCommand
    cmd: "_navi_call"
  }
})
