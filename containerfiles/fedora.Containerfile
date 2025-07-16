#FROM registry.fedoraproject.org/fedora:41 
FROM quay.io/podman/stable


# TODO: add back eza once available again
RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
    dnf update -y && \
    dnf install -y sqlite rustup helix curl git just awk \
    ripgrep fd python3 bash difftastic unar 7z unzip htop cmake litecli man \
    openssl-devel java-21-openjdk bat tokei hexyl age tree nodejs-bash-language-server \
    rakudo wget racket pandoc shellcheck inotify-tools g++ automake autoconf ncurses-devel && \
    dnf clean all

# ------
COPY --from=opt /opt/ /opt/
COPY ./filesystem/config /root/.config
COPY ./filesystem/examples /examples

ENV PATH="$PATH:/opt/cross/:/opt/dioxus/:/opt/cargo-audit:/opt/cargo-chef:/opt/nushell/:/opt/jujutsu:/opt/typst:/opt/zellij:/opt/starship:/opt/deno:/opt/intellij/bin:/opt/cuelang:/opt/gleam:/opt/zola:/opt/nickel:/opt/taplo:/opt/carapace:/opt/rebar3:/opt/mprocs:/opt/tinymist"
ENV PATH="/root/.local/share/mise/shims/:/root/.local/bin/:$PATH"
RUN curl https://mise.run | sh
RUN mise use --global erlang@27
RUN npm i -g vscode-langservers-extracted@4.10.0

ENV SHELL="nu"
ENV EDITOR="hx"
ENV VISUAL="hx"

RUN rustup-init -y && bash -lc 'rustup component add rust-analyzer'



# TODO: kotlin
# TODO: lume example project
# TODO: kotlin spring example project
# TODO: nickel and cuelang example files
# TODO: typst example file

ENTRYPOINT [ "sh", "-l", "-c", "zellij"]