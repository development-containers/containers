#!/bin/bash
set -xeuo pipefail

# Devcontainer ubuntu bash overrides our path changes. Well. Then we just set them again


declare -a paths=("/opt/nushell/" "/opt/typst" "/opt/zellij" "/opt/jujutsu" "/opt/starship" "/opt/deno" "/opt/intellij/bin" "/opt/cuelang" "/opt/gleam" "/opt/zola" "/opt/nickel" "/opt/taplo" "/opt/carapace")


path_statement () {
   echo -n 'if [[ "${PATH}" != *"' 
    echo -n "$1" 
    echo -n '"* ]]; then export PATH="${PATH}:' 
    echo -n "$1"
    echo '"; fi' 
}

for i in "${paths[@]}"
do
    echo "$i"
    path_statement "$i" >> /etc/bash.bashrc
    path_statement "$i" >> /home/codespace/.bashrc
        path_statement "$i" >> /home/codespace/.profile

done


cat /etc/bash.bashrc
cat /home/codespace/.bashrc

