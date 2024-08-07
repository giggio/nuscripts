source (if $WSL { 'alias-wsl.nu' } else { 'noop.nu' })

# aliases don't persist in conditionals: https://github.com/nushell/nushell/issues/5068
# if ((which bat | is-empty) and (not (which batcat | is-empty))) {
#   alias bat = batcat
# }
# because Ubuntu has bat set as batcat
alias bat = ^(if (which ^bat | is-empty) and (which ^batcat | is-not-empty) { (which ^batcat).path | get 0 } else { (which ^bat).path | get 0 })

alias nn = ^($env.HOME | path join bin n)
