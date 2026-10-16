# setup-ruby

<img src="public/icon.png" alt="" width="96">

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
