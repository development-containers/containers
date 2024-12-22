FROM ubuntu:24.04 AS builder
RUN apt update && apt -y install unar

# unpack nushell
ADD --checksum=sha256:7bcd2c64bc7028f8cdbb25f2f84d61b3c9418ce6c39e13c7f010d412f1e8711e https://github.com/nushell/nushell/releases/download/0.100.0/nu-0.100.0-x86_64-unknown-linux-gnu.tar.gz  /nu.tar.gz
RUN mkdir /opt/nushell && unar /nu.tar.gz -o /tmp/nu && mv /tmp/nu/**/* /opt/nushell

#unpack helix
ADD --checksum=sha256:c258204690c9080ed0d141b775bfdcd1eb57df6c3d26e83e1e439004fe10aa5c https://github.com/helix-editor/helix/releases/download/24.07/helix-24.07-x86_64-linux.tar.xz /hx.tar.xz
RUN mkdir /opt/helix && unar /hx.tar.xz -o /tmp/helix && mv /tmp/helix/**/* /opt/helix


#unpack typst
ADD --checksum=sha256:605130a770ebd59a4a579673079cb913a13e75985231657a71d6239a57539ec3 https://github.com/typst/typst/releases/download/v0.12.0/typst-x86_64-unknown-linux-musl.tar.xz  /typst.tar.xz
RUN mkdir /opt/typst && unar /typst.tar.xz -o /tmp/typst && mv /tmp/typst/**/* /opt/typst


#unpack zellij
ADD --checksum=sha256:b1c321a817d8a5baf55c2798f6ac7495bba925d686d9877e9604a50784bf6c78 https://github.com/zellij-org/zellij/releases/download/v0.41.2/zellij-x86_64-unknown-linux-musl.tar.gz /zellij.tar.xz
RUN mkdir /opt/zellij && unar /zellij.tar.xz -o /tmp/zellij && mv /tmp/zellij/* /opt/zellij

FROM ubuntu:24.04

RUN apt update && \
    apt upgrade -y && \
    apt install -y sqlite3 curl git just eza ripgrep fd-find python3 bash clang pkg-config build-essential libssl-dev unar

# install from builder
COPY --from=builder /opt/ /opt/
ENV PATH="$PATH:/opt/nushell/:/opt/helix:/opt/typst:/opt/zellij"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y



# TODO rust-analyser gleam typst pijul deno mprocs bottom difftastic
ENTRYPOINT [ "sh", "-l", "-c", "nu"]