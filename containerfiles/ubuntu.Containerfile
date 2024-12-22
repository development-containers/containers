FROM ubuntu:24.04 AS builder
RUN apt update && apt -y install unar

# unpack nushell
ADD --checksum=sha256:7bcd2c64bc7028f8cdbb25f2f84d61b3c9418ce6c39e13c7f010d412f1e8711e https://github.com/nushell/nushell/releases/download/0.100.0/nu-0.100.0-x86_64-unknown-linux-gnu.tar.gz  /nu.tar.gz
RUN mkdir /opt/nushell && unar /nu.tar.gz -o /tmp/nu && mv /tmp/nu/**/* /opt/nushell

#unpack helix
ADD --checksum=sha256:c258204690c9080ed0d141b775bfdcd1eb57df6c3d26e83e1e439004fe10aa5c https://github.com/helix-editor/helix/releases/download/24.07/helix-24.07-x86_64-linux.tar.xz /hx.tar.xz
RUN mkdir /opt/helix && unar /hx.tar.xz -o /tmp/helix && mv /tmp/helix/**/* /opt/helix



FROM ubuntu:24.04

RUN apt update && \
    apt upgrade -y && \
    apt install -y sqlite3 curl git just eza ripgrep fd-find python3 bash clang pkg-config build-essential libssl-dev unar

# install from builder
COPY --from=builder /opt/ /opt/
ENV PATH="$PATH:/opt/nushell/:/opt/helix"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y



# TODO rust-analyser gleam typst pijul deno mprocs bottom zellij difftastic
ENTRYPOINT [ "sh", "-l", "-c", "nu"]