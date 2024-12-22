FROM alpine:edge

RUN apk update && \
    apk upgrade && \
    apk add rust-analyzer sqlite gleam typst \
            nushell helix tree-sitter-grammars\
            curl git pijul deno rustup mprocs \
            just bottom zellij eza ripgrep fd python3 \
            bash difftastic
# TODO: unar https://gitlab.alpinelinux.org/alpine/aports/-/issues/5846
RUN rustup-init -y 
ENTRYPOINT [ "sh", "-l", "-c", "nu"]