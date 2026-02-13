#!/usr/bin/env nu

print (whoami)

# skip on alpine for now
if ('/etc/alpine-release' | path exists ) {
    print "Skipping alpine check"
    exit 0
}

nix-shell -p cowsay fortune bash --command "bash -c 'fortune | cowsay'" 