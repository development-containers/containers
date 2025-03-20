#FROM registry.fedoraproject.org/fedora:41 
FROM quay.io/podman/stable


RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
    dnf update -y && \
    dnf install -y rust-analyzer sqlite rustup helix curl git rustup just \
    eza ripgrep fd python3 bash difftastic unar 7z unzip htop cmake litecli man \
    openssl-devel java-21-openjdk bat tokei hexyl age tree nodejs-bash-language-server \
    rakudo wget racket pandoc shellcheck inotify-tools g++ automake autoconf ncurses-devel && \
    dnf clean all

# ------
COPY --from=opt /opt/ /opt/
COPY ./filesystem/config /root/.config
COPY ./filesystem/examples /examples

ENV PATH="$PATH:/opt/nushell/:/opt/jujutsu:/opt/typst:/opt/zellij:opt/typst:/opt/starship:/opt/deno:/opt/intellij/bin:/opt/cuelang:/opt/gleam:/opt/zola:/opt/nickel:/opt/taplo:/opt/carapace:/opt/rebar3:/opt/mprocs:/opt/red"
ENV PATH="/root/.local/share/mise/shims/:/root/.local/bin/:$PATH"
RUN curl https://mise.run | sh
RUN mise use --global erlang@27

ENV SHELL="nu"
ENV EDITOR="hx"
ENV VISUAL="hx"

RUN rustup-init -y 



# TODO: configure starship prompt to be *fancy*
# TODO: kotlin
# TODO: lume example project
# TODO: kotlin spring example project
# TODO: nickel and cuelang example files
# TODO: typst example file

ENTRYPOINT [ "sh", "-l", "-c", "zellij"]