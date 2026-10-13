#!/usr/bin/env bash
# Installed with --user-install (into ~/.gem), so no sudo. Gems the dotfiles use: wirble (irb colour), awesome_print (pry
# output), pry + extras. Run once per Ruby.
set -e
gem install --user-install wirble
gem install --user-install pry
gem install --user-install pry-doc
gem install --user-install awesome_print
# gem install --user-install pry-rails pry-byebug pry-rescue  # for Rails projects
