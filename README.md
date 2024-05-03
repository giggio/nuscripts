# Giovanni Bassi's Nushell files

These are my personal Nushell files.

## Installation instructions

Install Nushell, then run:

```nushell
git clone --recursive https://github.com/giggio/nuscripts.git <your directory>
# or use: git clone --recursive git@github.com:giggio/nuscripts.git
```

Set a symlink from `config.nu` and `env.nu` to the directory where you cloned this repo. For example, using PowerShell in Windows, assuming the scripts are cloned at `C:\p\nuscripts`:

```powershell
New-Item -ItemType SymbolicLink -Path $env:APPDATA\nushell\env.nu -Value C:\p\nuscripts\env.nu -Force
New-Item -ItemType SymbolicLink -Path $env:APPDATA\nushell\config.nu -Value C:\p\nuscripts\config.nu -Force
```

Run `./setup.nu` to set the environment file.

## Completions

Install [carapace-bin](https://github.com/rsteube/carapace-bin) and add
it to the `PATH`.

## Shell prompt

Install [Starship](https://starship.rs).

## Other tools

Install:

* [Zoxide](https://github.com/ajeetdsouza/zoxide)

## Contributing

Questions, comments, bug reports, and pull requests are all welcome. Submit them at
[the project on GitHub](https://github.com/giggio/nuscripts).

Bug reports that include steps-to-reproduce (including code) are the
best. Even better, make them in the form of pull requests.

## Author

[Giovanni Bassi](https://twitter.com/giovannibassi).

## License

Licensed under the MIT License.
