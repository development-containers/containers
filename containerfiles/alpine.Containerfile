FROM alpine:edge

RUN apk update && \
    apk upgrade && \
    apk add sqlite gleam typst 7zip \
            nushell helix helix-tree-sitter-vendor \
            curl git pijul deno rustup mprocs wget \
            just bottom zellij eza ripgrep fd python3 \
            bash difftastic openjdk21-jdk grep cue-cli mandoc man-pages \
            zola nickel nickel-language-server starship taplo carapace jujutsu \
            bat erlang rebar3 inotify-tools litecli tokei hexyl age pandoc clang
# TODO: unar https://gitlab.alpinelinux.org/alpine/aports/-/issues/5846
RUN rustup-init -y && bash -lc 'rustup component add rust-analyzer'

COPY ./filesystem/config /root/.config
COPY ./filesystem/examples /examples

ENV SHELL=nu
CMD [ "zellij"]