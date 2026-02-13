FROM alpine:edge

RUN apk update && \
    apk upgrade && \
    apk add sqlite gleam typst 7zip \
            nushell helix helix-tree-sitter-vendor lnav \
            curl git pijul deno rustup mprocs wget htop\
            just bottom zellij eza ripgrep fd python3 \
            bash difftastic openjdk21-jdk grep cue-cli docs \
            zola nickel nickel-language-server starship taplo carapace jujutsu \
            bat erlang rebar3 inotify-tools litecli tokei hexyl age pandoc clang jdtls \
            binaryen wasm-tools cargo-audit cue-cli go gopls cue-cli cargo-audit cargo-chef tini
# TODO: unar https://gitlab.alpinelinux.org/alpine/aports/-/issues/5846
# TODO: wabt once out of testing



COPY ./filesystem/config /root/.config
COPY ./filesystem/examples /examples

ENV SHELL=nu
RUN rustup-init -y && bash -lc 'rustup component add rust-analyzer'
RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable && nix-channel --update

CMD [ "tini", "zellij"]