#!/usr/bin/env nu

mut configs = "# this file is automatically generated, do not edit"
mut nushell_config_dir = $env.CURRENT_FILE | path dirname
if $nu.os-info.family == windows {
  $nushell_config_dir = $nushell_config_dir | str replace --all \ \\
}
$configs += $"\nconst NUSHELL_CONFIG_DIR = \"($nushell_config_dir)\""
if $nu.os-info.family == unix {
  let wsl = $nu.os-info.family == unix and (open /proc/version --raw) =~ 'microsoft'
  $configs += $"\nconst WSL = ($wsl)"
  if ($nu.current-exe | str starts-with /nix/) {
    $configs += "\nconst NIX = true"
  }
}
$configs += "\n"
let environment_script_dir = $nushell_config_dir | path join scripts dynamic
if not ($environment_script_dir | path exists) {
   mkdir $environment_script_dir
}
let environment_script_path = $environment_script_dir | path join environment.nu
echo $configs | save -f $environment_script_path
