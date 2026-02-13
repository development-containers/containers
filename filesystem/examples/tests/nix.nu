#!/usr/bin/env nu

nix-shell -p cowsay fortune bash --command "bash -c 'fortune | cowsay'" 