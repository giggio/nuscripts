# Giovanni Bassi's Nushell files

Main repo: [codeberg.org/giggio/nuscripts](https://codeberg.org/giggio/nuscripts)

These are my personal Nushell files.

## Installation instructions

Install Nushell, then run:

```nushell
git clone --recursive https://codeberg.org/giggio/nuscripts.git <your directory>
# or use: git clone --recursive git@codeberg.org:giggio/nuscripts.git
```

Set a symlink from the default nushell config directory to the directory where
you cloned this repo. For example, using PowerShell in Windows, assuming
the scripts are cloned at `C:\p\nuscripts`:

```powershell
New-Item -ItemType SymbolicLink -Path $env:APPDATA\nushell\ -Value C:\p\nuscripts\ -Force
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

Questions, comments, bug reports, and pull requests are all welcome.  Submit them at
[the project on Codeberg](https://codeberg.com/giggio/nuscripts/).

Bug reports that include steps-to-reproduce (including code) are the best. Even better, make them in the form of pull
requests. Pull requests on Github will probably be ignored, so avoid them.

## Author

[Giovanni Bassi](https://links.giggio.net/bio)

## License

Licensed under the MIT license.
