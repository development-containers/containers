FROM alpine:edge

RUN apk update && \
    apk upgrade && \
    apk add rust-analyzer sqlite gleam typst \
            nushell helix tree-sitter-grammars\
            curl git pijul deno nodejs rustup mprocs \
            just bottom zellij eza ripgrep fd python3 \
            bash 
RUN rustup-init -y 
ENTRYPOINT [ "sh", "-l", "-c", "nu"]