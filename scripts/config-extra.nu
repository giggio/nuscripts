$env.STARSHIP_CONFIG = ($nu.config-path | path dirname | path join starship.toml)
$env.config.show_banner = false
$env.config.history = {
    max_size: 100_000
    sync_on_enter: false
    file_format: "sqlite"
    isolation: true
}
$env.config.cursor_shape.vi_insert = line
$env.config.cursor_shape.vi_normal = block
$env.config.buffer_editor = vim
$env.config.edit_mode = vi
$env.config.shell_integration = true

source config-extra-windows.nu
source config-extra-linux.nu

source starship.nu
source alias.nu
source zoxide.nu
source completions.nu
