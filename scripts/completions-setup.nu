let DIR = ($env.CURRENT_FILE | path expand | path dirname)
let CARAPACE_INIT = ($DIR | path join dynamic | path join carapace-init.nu)
if not ($CARAPACE_INIT | path exists) {
  if (which carapace | is-empty) {
    touch $CARAPACE_INIT
  } else {
    carapace _carapace nushell | save --force $CARAPACE_INIT
  }
}
