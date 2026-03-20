#!/bin/sh
printf '\033c\033]0;%s\a' Projeto Final
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Tvzinha.x86_64" "$@"
