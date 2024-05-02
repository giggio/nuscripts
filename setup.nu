#!/usr/bin/env nu

let wsl = (open /proc/version --raw) =~ 'microsoft'
let environment_script_path = $nu.config-path | path dirname | path join scripts dynamic environment.nu
echo $"const WSL = ($wsl)" | save -f $environment_script_path
