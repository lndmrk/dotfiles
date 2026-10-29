<!--
SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

# lndmrk's dotfiles

These are my personal dotfiles. They're self-contained and may be used on their
own, but are best used as
[Home Manager](https://github.com/nix-community/home-manager) modules.

## Usage

Below is an example of how to use them as Home Manager modules.

```nix
{
  inputs = {
    dotfiles = {
      url = "<repo>";
      flake = false;
    };
    # [...]
  };

  outputs =
    {
      dotfiles,
      home-manager,
      ...
    }:
    {
      homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
        modules =
          map (m: "${dotfiles}/${m}") [
            "lib.nix"
            "git"
            # [...]
          ]
          # Optionally configure additional settings.
          ++ [ { dotfiles.live = true; } ];
      };
    };
}
```

## License

This project is [REUSE](https://reuse.software/) compliant. Copyright and
license information for every file is specified using SPDX tags.
