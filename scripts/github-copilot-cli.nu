def copilot_helper [command, ...args] {
  use std log
  let TMPFILE = mktemp --tmpdir --suffix .nu
  try {
    github-copilot-cli $command $args --shellout $TMPFILE
    if $env.LAST_EXIT_CODE == 0 {
      if ($TMPFILE | path exists) {
        let FIXED_CMD = open --raw $TMPFILE
        history insert $FIXED_CMD
        try {
          # todo: can't eval: https://github.com/nushell/nushell/issues/2812
          # also can't source dynamic path in nushell, see: https://github.com/nushell/nushell/issues/8214
          # bash:
          #  eval "$FIXED_CMD"
          # will run as standalone
          nu $TMPFILE
         } catch { }
      } else {
        log error "Apologies! Extracting command failed"
      }
    } else {
      log error "Command failed"
    }
  } catch { |e|
    log error $"Command failed: ($e)"
  }
  rm $TMPFILE
  ignore
}

alias ?? = copilot_helper what-the-shell
alias wts = copilot_helper what-the-shell
alias git? = copilot_helper git-assist
alias gh? = copilot_helper gh-assist
