<p align="center"><img src="public/icon.png" alt="setup-ruby icon" width="128" height="128"></p>

<h1 align="center">setup-ruby</h1>

<p align="center"><b>Ruby console dotfiles (.irbrc, .pryrc, .gemrc), symlinked into $HOME from version control.</b></p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-27%20%C2%B7%20daily%20use-000000?style=for-the-badge&logo=apple&logoColor=white" alt="macOS 27 · daily use" />
  <img src="https://img.shields.io/badge/Ruby-irb%20%C2%B7%20pry-CC342D?style=for-the-badge&logo=ruby&logoColor=white" alt="Ruby irb · pry" />
  <img src="https://img.shields.io/badge/Shell-POSIX%20sh-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white" alt="Shell POSIX sh" />
</p>

<p align="center">
  <a href="https://github.com/lawrence-berry/setup-ruby/actions/workflows/macos.yml"><img src="https://img.shields.io/github/actions/workflow/status/lawrence-berry/setup-ruby/macos.yml?branch=main&style=for-the-badge&logo=apple&logoColor=white&label=macOS%2015" alt="macOS 15 CI status" /></a>
  <a href="https://github.com/lawrence-berry/setup-ruby/actions/workflows/linux.yml"><img src="https://img.shields.io/github/actions/workflow/status/lawrence-berry/setup-ruby/linux.yml?branch=main&style=for-the-badge&logo=ubuntu&logoColor=white&label=Ubuntu%2024.04" alt="Ubuntu 24.04 CI status" /></a>
</p>

Ruby console dotfiles — `.irbrc`, `.pryrc`, `.gemrc` — kept in version control and symlinked into `$HOME`.

## Install

```sh
./install.sh   # symlinks the dotfiles into ~ (backs up any existing file), then runs install_gems.sh
```

Re-runnable. `install_gems.sh` (`wirble`, `awesome_print`, `pry`…) runs only if `gem` is on the PATH, and a failure there doesn't fail the install — the dotfiles degrade gracefully without the gems.

## What's here

- `.irbrc` — history, simple prompt, `hist`/`cp`/`r!` helpers; colour via wirble if installed.
- `.pryrc` — prompt with Rails/Ruby version, `copy` command, adds `spec`/`test`/`lib` to the load path, awesome_print output if installed.
- `.gemrc` — `--no-document` and friends.

## Tests

CI lints `install.sh` with ShellCheck, then runs it twice in a scratch `HOME` on Ubuntu and macOS and checks that all three dotfiles are symlinks into this repo.

Part of the [`setup-*`](https://lawrence-berry.github.io/setup) family; on a blank machine, `curl -fsSL https://lawrence-berry.github.io/setup | sh` installs them all (setup-mac and setup-iterm on macOS only).
