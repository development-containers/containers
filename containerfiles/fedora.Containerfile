FROM registry.fedoraproject.org/fedora:41 

RUN dnf update -y && \
    dnf install -y rust-analyzer sqlite rustup helix curl git rustup just \
    eza ripgrep fd python3 bash difftastic unar 7z unzip htop cmake elixir \
    erlang openssl-devel java-latest-openjdk bat tokei hexyl age tree \
    rakudo wget racket pandoc podman docker && \
    dnf clean all

# ------
COPY --from=opt /opt/ /opt/
COPY ./filesystem/config /root/.config
COPY ./filesystem/examples /examples

ENV PATH="$PATH:/opt/nushell/:/opt/typst:/opt/zellij:opt/typst:/opt/jujutsu:/opt/starship:/opt/deno:/opt/intellij/bin:/opt/cuelang:/opt/gleam:/opt/zola:/opt/nickel:/opt/taplo:/opt/carapace"


ENV SHELL="nu"
ENV EDITOR="hx"
ENV VISUAL="hx"

RUN rustup-init -y 
RUN sh -l -c "cargo install --locked nickel-lang-lsp"



# TODO: configure starship prompt to be *fancy*
# TODO: rebar3 https://rebar3.org/docs/getting-started/
# TODO: kotlin
# TODO: setup difftastic for git
# TODO: lume example project
# TODO: kotlin spring example project
# TODO: nickel and cuelang example files
# TODO: typst example file
# TODO: script that checks if any of the tools we install manually have newer versions available

ENTRYPOINT [ "sh", "-l", "-c", "zellij"]