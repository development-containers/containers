FROM mcr.microsoft.com/devcontainers/universal

RUN apt update && \
    apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y sqlite3 curl git ripgrep fd-find python3 bash clang pkg-config build-essential libssl-dev unar

# install from builder
COPY --from=opt /opt/ /opt/
COPY ./filesystem/etc/fix-ubuntu-path.sh /
RUN /fix-ubuntu-path.sh && rm /fix-ubuntu-path.sh


USER codespace
COPY --chown=codespace:codespace ./filesystem/examples /examples
COPY --chown=codespace:codespace ./filesystem/config /home/codespace/.config

ENV SHELL="nu"
ENV PATH="$PATH:/opt/nushell/:/opt/typst:/opt/zellij:/opt/jujutsu:/opt/starship:/opt/deno:/opt/intellij/bin:/opt/cuelang:/opt/gleam:/opt/zola:/opt/nickel:/opt/taplo:/opt/carapace:/opt/rebar3"

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y
RUN pipx install rust-just


ENV PATH="/root/.local/share/mise/shims/:/root/.local/bin/:$PATH"
RUN curl https://mise.run | sh
RUN mise use --global erlang@27

# ENV EDITOR="hx"
# ENV VISUAL="hx"

ENTRYPOINT [ "sh", "-l", "-c", "zellij"]