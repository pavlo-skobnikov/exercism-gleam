#!/usr/bin/env bash

selected="$(find . -mindepth 1 -maxdepth 1 -type d | fzf)"

pushd $selected || exit

gleam build && gleam test

popd || exit
