$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu


# TODO: remove when the next rustup release is out and this is done automatically
let cargo_bin = ("~/.cargo/bin" | path expand)
if ( $cargo_bin not-in ($env.Path | split row (char esep))) {
  $env.Path = ($env.Path | prepend $cargo_bin)
}