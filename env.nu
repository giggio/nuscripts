source scripts/dynamic/environment.nu
$env.NU_LIB_DIRS = [
  ($NUSHELL_CONFIG_DIR | path join lib)
]
