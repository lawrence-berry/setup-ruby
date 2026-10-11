# setup-ruby

Ruby console dotfiles — `.irbrc`, `.pryrc`, `.gemrc` — kept in version control and symlinked into `$HOME`.

## Install

```sh
./install.sh        # symlinks the dotfiles into ~ (backs up any existing file)
./install_gems.sh   # optional: installs the gems the dotfiles use
```

Re-runnable. The gems (`wirble`, `awesome_print`, `pry`…) are optional — the dotfiles degrade gracefully if they're missing.

## What's here

- `.irbrc` — history, simple prompt, `hist`/`cp`/`r!` helpers; colour via wirble if installed.
- `.pryrc` — prompt with Rails/Ruby version, `copy` command, adds `spec`/`test`/`lib` to the load path, awesome_print output if installed.
- `.gemrc` — `--no-document` and friends.
