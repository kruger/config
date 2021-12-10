#!/bin/sh
git branch -a | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout
