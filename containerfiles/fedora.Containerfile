FROM fedora:41 as base

RUN dnf update -y && \
    dnf install -y rust-analyzer sqlite rustup nu helix curl git rustup just eza ripgrep fd python3 bash difftastic unar 7z unzip htop cmake elixir erlang openssl-devel java-latest-openjdk

FROM base AS builder
RUN dnf update -y && dnf install -y unar

# unpack nushell
ADD --checksum=sha256:7bcd2c64bc7028f8cdbb25f2f84d61b3c9418ce6c39e13c7f010d412f1e8711e https://github.com/nushell/nushell/releases/download/0.100.0/nu-0.100.0-x86_64-unknown-linux-gnu.tar.gz  /nu.tar.gz
RUN mkdir /opt/nushell && unar /nu.tar.gz -o /tmp/nu && mv /tmp/nu/**/* /opt/nushell

#unpack typst
ADD --checksum=sha256:605130a770ebd59a4a579673079cb913a13e75985231657a71d6239a57539ec3 https://github.com/typst/typst/releases/download/v0.12.0/typst-x86_64-unknown-linux-musl.tar.xz  /typst.tar.xz
RUN mkdir /opt/typst && unar /typst.tar.xz -o /tmp/typst && mv /tmp/typst/**/* /opt/typst

#unpack zellij
ADD --checksum=sha256:b1c321a817d8a5baf55c2798f6ac7495bba925d686d9877e9604a50784bf6c78 https://github.com/zellij-org/zellij/releases/download/v0.41.2/zellij-x86_64-unknown-linux-musl.tar.gz /zellij.tar.xz
RUN mkdir /opt/zellij && unar /zellij.tar.xz -o /tmp/zellij && mv /tmp/zellij/* /opt/zellij

# unpack cuelang
ADD --checksum=sha256:60c46ec5b90190c22a96ab3529ad363d03b687331bbeb6d7d8097a2983d7716d https://github.com/cue-lang/cue/releases/download/v0.11.1/cue_v0.11.1_linux_amd64.tar.gz cue.tar.gz
RUN mkdir /opt/cuelang && unar /cue.tar.gz -o /tmp/cue && mv /tmp/cue/cue/* /opt/cuelang

# unpack gleam
ADD --checksum=sha256:db9c07b41d8aacf4cd7235efba438af1a5dadefd94f1a6e08534d247d883bc88 https://github.com/gleam-lang/gleam/releases/download/v1.6.3/gleam-v1.6.3-x86_64-unknown-linux-musl.tar.gz gleam.tar.gz
RUN mkdir /opt/gleam && unar /gleam.tar.gz -o /tmp/gleam && mv /tmp/gleam/* /opt/gleam

# unpack starship
ADD --checksum=sha256:744e21eb2e61b85b0c11378520ebb9e94218de965bca5b8c2266f6c3e23ff5be https://github.com/starship/starship/releases/download/v1.21.1/starship-x86_64-unknown-linux-musl.tar.gz starship.tar.gz
RUN mkdir /opt/starship && unar /starship.tar.gz -o /tmp/starship && mv /tmp/starship/* /opt/starship

#unpack intelij
# TODO: uncomment once we have gui apps working
# ADD --checksum=sha256:b183b126de2cd457475eea184874b5da2fa33ba5ae2ff874bdc8c1d534156428 https://download.jetbrains.com/idea/ideaIC-2024.3.1.1.tar.gz intellij.tar.gz
# RUN mkdir /opt/intellij && unar /intellij.tar.gz -o /tmp/intellij && mv /tmp/intellij/**/* /opt/intellij

#unpack deno
ADD --checksum=sha256:54a81939cccb2af114c4d0a68a554cf4a04b1f08728e70f663f83781de19d785 https://github.com/denoland/deno/releases/download/v2.1.4/deno-x86_64-unknown-linux-gnu.zip /deno.zip
RUN mkdir /opt/deno && unar /deno.zip -o /tmp/deno && mv /tmp/deno/* /opt/deno

#unpack zola
ADD --checksum=sha256:0798e69b86c628ddcb264ebd86c8cc8dce7670b9049060bf94faa73f6857cd9c https://github.com/getzola/zola/releases/download/v0.19.2/zola-v0.19.2-x86_64-unknown-linux-gnu.tar.gz /zola.tar.gz
RUN mkdir /opt/zola && unar /zola.tar.gz -o /tmp/zola && mv /tmp/zola/* /opt/zola


FROM base


COPY --from=builder /opt/ /opt/
ENV PATH="$PATH:/opt/nushell/:/opt/helix:/opt/typst:/opt/zellij:/opt/starship:/opt/deno:/opt/intellij/bin:/opt/cuelang:/opt/gleam:/opt/zola"

RUN rustup-init -y 
# RUN sh -l -c "cargo install --locked mprocs"

ENV SHELL="nu"
ENV EDITOR="hx"
ENV VISUAL="hx"

# TODO: enable starship in nu
# TODO: rebar3 https://rebar3.org/docs/getting-started/
# TODO: kotlin
ENTRYPOINT [ "sh", "-l", "-c", "zellij"]