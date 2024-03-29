<!--
SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

# lndmrk's dotfiles

These are my personal dotfiles organized into *bundles*. A bundle is essentially
a Python module and a collection of dotfiles without the initial dot in the
name; it's implied.

## Usage

The `dotfiles` program is used to orchestrate everything. It can be installed by
running

```
$ ./dotfiles install
```

The program will find any bundles relative to this directory. It will also
handle any inner Git repositories along with its bundles.

## License

This project is [REUSE](https://reuse.software/) compliant. The copyright and
license information for all files are specified using SPDX tags.
