#!/bin/bash
set -euo pipefail

# Devcontainer ubuntu bash overrides our path changes. Well. Then we just set them again


declare -a paths=("/opt/nushell/" "/opt/typst" "/opt/zellij" "/opt/jujutsu" "/opt/starship" "/opt/deno" "/opt/intellij/bin" "/opt/cuelang" "/opt/gleam" "/opt/zola" "/opt/nickel" "/opt/taplo" "/opt/carapace")

for i in "${paths[@]}"
do
   echo "$i"
    echo -n 'if [[ "${PATH}" != *"' >> /etc/bash.bashrc
    echo -n "$i" >>  /etc/bash.bashrc
    echo -n '"* ]]; then export PATH="${PATH}:' >> /etc/bash.bashrc
    echo -n "$i" >>  /etc/bash.bashrc
    echo '"; fi' >> /etc/bash.bashrc
done

