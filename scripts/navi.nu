if (which navi | is-empty) {
  return
}

let navi_command = open (navi info config-path) | get -i 'shell' | default { command: null } | get -i command | default 'bash'

# use dotfiles cheats if it exists
let cheats_dir = ($nu.config-path | path dirname | path join .. cheats | path expand)
if ($cheats_dir | path exists) {
  let os = if $nu.os-info.family == unix { 'linux' } else { 'windows' }
  $env.NAVI_PATH = $"($cheats_dir)/dist/common/(char esep)($cheats_dir)/dist/nushell/(char esep)($cheats_dir)/dist/($os)/common/(char esep)($cheats_dir)/dist/($os)/nushell/"
}

def _navi_widget [--run, --display] {
  let input = commandline
  let os = if $nu.os-info.family == unix { 'linux' } else { 'windows' }
  if ($env | get NAVI_ORIGINAL_PATH -i | is-empty) {
    $env.NAVI_PATH = if $run or $display {
      $"($cheats_dir)/dist/common/(char esep)($cheats_dir)/dist/bash/(char esep)($cheats_dir)/dist/($os)/common/(char esep)($cheats_dir)/dist/($os)/bash/"
    } else {
      $"($cheats_dir)/dist/common/(char esep)($cheats_dir)/dist/nushell/(char esep)($cheats_dir)/dist/($os)/common/(char esep)($cheats_dir)/dist/($os)/nushell/"
    }
  }
  let last_command = ($input | navi fn widget::last_command)
  let result = if ($last_command == "") { navi --print } else { navi --print --query $last_command } | str trim

  if $result == "" {
    return
  }
  let tmpfile = mktemp --tmpdir --suffix .nu
  try {
    $result | save --force $tmpfile
    if $run {
      ^$navi_command $tmpfile
      history insert $"^($navi_command) -c '($result)'"
      commandline -r ''
    } else if $display {
      commandline -r $"^($navi_command) -c '($result)'"
    } else {
      commandline -r $result
      # we can't do that, cheats are written in bash:
      # history insert $result
      # nu $tmpfile
    }
  } catch { |e|
    use std log
    log error $"Command failed: ($e)"
  }
  rm $tmpfile
  ignore
}

$env.config.keybindings = ($env.config.keybindings | append {
  name: navi
  modifier: control
  keycode: char_g
  mode: [emacs vi_normal vi_insert]
  event: {
    send: ExecuteHostCommand
    cmd: "_navi_widget"
  }
})

$env.config.keybindings = ($env.config.keybindings | append {
  name: navi
  modifier: control
  keycode: char_h
  mode: [emacs vi_normal vi_insert]
  event: {
    send: ExecuteHostCommand
    cmd: "_navi_widget --run"
  }
})

$env.config.keybindings = ($env.config.keybindings | append {
  name: navi
  modifier: control
  keycode: char_f
  mode: [emacs vi_normal vi_insert]
  event: {
    send: ExecuteHostCommand
    cmd: "_navi_widget --display"
  }
})
