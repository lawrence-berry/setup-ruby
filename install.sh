#!/bin/sh
# Symlinks the Ruby dotfiles into $HOME. Safe to re-run. Any existing real
# file is moved aside to <name>.bak before the symlink is created.
set -e
dir="$(cd "$(dirname "$0")" && pwd)"
for f in .irbrc .pryrc .gemrc; do
  target="$HOME/$f"
  # Already our symlink? leave it.
  [ "$(readlink "$target" 2>/dev/null)" = "$dir/$f" ] && continue
  [ -e "$target" ] && mv "$target" "$target.bak" && echo "backed up $target -> $target.bak"
  ln -sf "$dir/$f" "$target"
  echo "linked $target -> $dir/$f"
done

# Gems the dotfiles use. Skipped when there's no Ruby, and a failed gem doesn't
# fail the install (the dotfiles degrade gracefully without them).
if command -v gem >/dev/null 2>&1; then
  bash "$dir/install_gems.sh" || echo "note: gem install failed; the dotfiles work without the gems"
fi
