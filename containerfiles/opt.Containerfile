FROM registry.fedoraproject.org/fedora:41 

RUN dnf install -y unar

ENV NUSHELL_VERSION=0.102.0
ENV TYPST_VERSION=0.13.0
ENV ZELLIJ_VERSION=0.41.2
ENV CUELANG_VERSION=0.11.1
ENV GLEAM_VERSION=1.9.1
ENV STARSHIP_VERSION=1.22.1
ENV DENO_VERSION=2.2.4
ENV ZOLA_VERSION=0.20.0
ENV NICKEL_VERSION=1.10.0
ENV TAPLO_VERSION=0.9.3
ENV CARAPACE_VERSION=1.2.1
ENV JUJUTSU_VERSION=0.26.0
ENV RED_VERSION=66


#unpack jujutsu
ADD --checksum=sha256:9f0be0f1348a2372b7c08d0130cae994ee9061f9a6c2eebe458f9266cd1e0faa https://github.com/jj-vcs/jj/releases/download/v${JUJUTSU_VERSION}/jj-v${JUJUTSU_VERSION}-x86_64-unknown-linux-musl.tar.gz /jj.tar.gz
RUN mkdir /opt/jujutsu && unar /jj.tar.gz -o /tmp/jujutsu && mv /tmp/jujutsu/**/* /opt/jujutsu

# unpack nushell
ADD --checksum=sha256:c4d9a3388d893e8c923b1a5363dbb9c7f081b71a4a5867767d7907632ecc0929 https://github.com/nushell/nushell/releases/download/${NUSHELL_VERSION}/nu-${NUSHELL_VERSION}-x86_64-unknown-linux-musl.tar.gz  /nu.tar.gz
RUN mkdir /opt/nushell && unar /nu.tar.gz -o /tmp/nu && mv /tmp/nu/**/* /opt/nushell

#unpack typst
ADD --checksum=sha256:cd1148da61d6844e62c330fc6222e988480acafe33b76daec8eb5d221258feb6 https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz  /typst.tar.xz
RUN mkdir /opt/typst && unar /typst.tar.xz -o /tmp/typst && mv /tmp/typst/**/* /opt/typst

#unpack zellij
ADD --checksum=sha256:b1c321a817d8a5baf55c2798f6ac7495bba925d686d9877e9604a50784bf6c78 https://github.com/zellij-org/zellij/releases/download/v${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz /zellij.tar.xz
RUN mkdir /opt/zellij && unar /zellij.tar.xz -o /tmp/zellij && mv /tmp/zellij/* /opt/zellij

# unpack cuelang
ADD --checksum=sha256:60c46ec5b90190c22a96ab3529ad363d03b687331bbeb6d7d8097a2983d7716d https://github.com/cue-lang/cue/releases/download/v${CUELANG_VERSION}/cue_v${CUELANG_VERSION}_linux_amd64.tar.gz /cue.tar.gz
RUN mkdir /opt/cuelang && unar /cue.tar.gz -o /tmp/cue && mv /tmp/cue/cue/* /opt/cuelang

# unpack gleam
ADD --checksum=sha256:e8757a6585b0d6dcd0718c3ddd4a847a4c906ef6cea7071a4e9abd2242ebbc75 https://github.com/gleam-lang/gleam/releases/download/v${GLEAM_VERSION}/gleam-v${GLEAM_VERSION}-x86_64-unknown-linux-musl.tar.gz /gleam.tar.gz
RUN mkdir /opt/gleam && unar /gleam.tar.gz -o /tmp/gleam && mv /tmp/gleam/* /opt/gleam

# unpack starship
ADD --checksum=sha256:62c91b5ecc7f8c8c6ea7ffea42a98bd2e6a2d29daf61562fac04daece18a6461 https://github.com/starship/starship/releases/download/v${STARSHIP_VERSION}/starship-x86_64-unknown-linux-musl.tar.gz /starship.tar.gz
RUN mkdir /opt/starship && unar /starship.tar.gz -o /tmp/starship && mv /tmp/starship/* /opt/starship

#unpack intelij
# TODO: uncomment once we have gui apps working
# ADD --checksum=sha256:b183b126de2cd457475eea184874b5da2fa33ba5ae2ff874bdc8c1d534156428 https://download.jetbrains.com/idea/ideaIC-2024.3.1.1.tar.gz intellij.tar.gz
# RUN mkdir /opt/intellij && unar /intellij.tar.gz -o /tmp/intellij && mv /tmp/intellij/**/* /opt/intellij

#unpack deno
ADD --checksum=sha256:9a260a624cab6e61f7603957f94f638d68739d8c6ac8c38bc337521266603a7c https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip /deno.zip
RUN mkdir /opt/deno && unar /deno.zip -o /tmp/deno && mv /tmp/deno/* /opt/deno

#unpack zola
ADD --checksum=sha256:ca7ed5b33a739c5b5b35a0e207e5c3578a652cd12b61c675763b3ff34c322d08 https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz /zola.tar.gz
RUN mkdir /opt/zola && unar /zola.tar.gz -o /tmp/zola && mv /tmp/zola/* /opt/zola

#unpack nickel
ADD --checksum=sha256:871eff55beaf30cf516ac57eaba3f9bcc2f7070543370f9be796aaf2e0d832da https://github.com/tweag/nickel/releases/download/${NICKEL_VERSION}/nickel-x86_64-linux /nickel
ADD --checksum=sha256:9bf94cf85cab6f89b4b3e9edeff4fe41df81a3edd024c610e27cfc706e6f3e60 https://github.com/tweag/nickel/releases/download/${NICKEL_VERSION}/nls-x86_64-linux /nls
RUN mkdir /opt/nickel && mv /nls /opt/nickel/nls && chmod +x /opt/nickel/nls && mv /nickel /opt/nickel/nickel && chmod +x /opt/nickel/nickel 


#unpack taplo
ADD --checksum=sha256:889efcfa067b179fda488427d3b13ce2d679537da8b9ed8138ba415db7da2a5e https://github.com/tamasfe/taplo/releases/download/${TAPLO_VERSION}/taplo-linux-x86_64.gz /taplo.gz
RUN mkdir /opt/taplo &&  unar /taplo.gz -o /opt/taplo/ && chmod +x /opt/taplo/taplo


#unpack carapace
ADD --checksum=sha256:78f87b0f23aec24de91e14872cf4fdbf2a73958d5e658bf5fa93398ed315165f https://github.com/carapace-sh/carapace-bin/releases/download/v${CARAPACE_VERSION}/carapace-bin_${CARAPACE_VERSION}_linux_amd64.tar.gz /carapace.tar.gz
RUN mkdir /opt/carapace &&  unar /carapace.tar.gz -o /tmp/carapace/ && mv /tmp/carapace/carapace/* /opt/carapace


#unpack rebar3
ADD --checksum=sha256:d2d31cfb98904b8e4917300a75f870de12cb5167cd6214d1043e973a56668a54 https://github.com/erlang/rebar3/releases/download/3.24.0/rebar3 /opt/rebar3/rebar3
RUN chmod +x /opt/rebar3/rebar3

#unpack mprocs
ADD --checksum=sha256:8708b84540cbde9fcff123528a7b0a679eaf7b73bc2e070ba4b96e741ea00b03 https://github.com/pvolok/mprocs/releases/download/v0.7.2/mprocs-0.7.2-linux-x86_64-musl.tar.gz /mprocs.tar.gz
RUN mkdir /opt/mprocs &&  unar /mprocs.tar.gz -o /tmp/mprocs/ && mv /tmp/mprocs/* /opt/mprocs

#get red
#ADD --checksum=sha256:625a7cbe17955022078397567c55c473ca3f8f74a54f2253e8d4ab1bccaa5c11  https://static.red-lang.org/dl/linux/red-cli-066 /tmp/red
#RUN mkdir /opt/red && mv /tmp/red /opt/red//red && chmod +x /opt/red/red
