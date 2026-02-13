#!/usr/bin/env nu

print (whoami)

nix-shell -p cowsay fortune bash --command "bash -c 'fortune | cowsay'" 