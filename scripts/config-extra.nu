$env.STARSHIP_CONFIG = ($NUSHELL_CONFIG_DIR | path join starship.toml)
$env.config.show_banner = false
$env.config.history = {
    max_size: 100_000
    sync_on_enter: false
    file_format: "sqlite"
    isolation: true
}
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
$env.config.buffer_editor = "vim"
$env.config.edit_mode = "vi"
$env.config.shell_integration.osc9_9 = true
$env.config.highlight_resolved_externals = true

source (if $nu.os-info.family == unix { 'config-extra-linux.nu' } else { 'config-extra-windows.nu' })

source starship.nu
source alias.nu
source zoxide.nu
source history-command.nu
source completions.nu
# to create from bash version: sed -E 's/alias ([a-z]*)='(.*)'/alias \1 = \2/' ./lib/kubectl-aliases/.kubectl_aliases | save scripts/dynamic/kubectl_aliases.nu
# todo: sourcing of kubectl aliases temporarily disabled, as nushell will always parse the file, which is adding 1 second to the shell startup time
# source source-kubectl_aliases.nu
source source-kubecolor_aliases.nu
source github-copilot-cli.nu
source navi.nu
