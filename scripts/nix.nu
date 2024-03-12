if ($"($env.HOME)/.nix-profile/bin" | path exists) {
  std path add $"($env.HOME)/.nix-profile/bin"
}

if ("/nix/var/nix/profiles/default/bin" | path exists) {
  std path add /nix/var/nix/profiles/default/bin
}
