FROM mcr.microsoft.com/devcontainers/universal

RUN apt update && \
    apt upgrade -y && \
    apt install -y sqlite3 curl git ripgrep fd-find python3 bash clang pkg-config build-essential libssl-dev unar

# install from builder
COPY --from=opt /opt/ /opt/
COPY ./filesystem/examples /examples

USER codespace
COPY ./filesystem/config ~/.config
ENV PATH="$PATH:/opt/nushell/:/opt/helix:/opt/typst:/opt/zellij:/opt/starship:/opt/deno:/opt/intellij/bin:/opt/cuelang:/opt/gleam:/opt/zola:/opt/nickel:/opt/taplo:/opt/carapace"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y
RUN pipx install rust-just

ENV SHELL="nu"
ENV EDITOR="hx"
ENV VISUAL="hx"

ENTRYPOINT [ "sh", "-l", "-c", "nu"]