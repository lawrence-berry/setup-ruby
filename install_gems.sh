#!/usr/bin/env bash
# Gems the dotfiles make use of: wirble (irb colour), awesome_print (pry
# output), pry + extras. Run once per Ruby.
set -e
gem install wirble
gem install pry
gem install pry-doc
gem install awesome_print
gem install mdless
# gem install pry-rails pry-byebug pry-rescue  # for Rails projects
