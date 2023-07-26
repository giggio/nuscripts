$env.STARSHIP_CONFIG = ($nu.config-path | path dirname | path join starship.toml)
$env.config.show_banner = false
$env.config.history.file_format = 'sqlite'
$env.config.cursor_shape.vi_insert = line
$env.config.cursor_shape.vi_normal = block
$env.config.buffer_editor = vim
$env.config.edit_mode = vi
$env.config.shell_integration = true
source starship.nu
source alias.nu
source zoxide.nu
source completions.nu
source config-wsl.nu
