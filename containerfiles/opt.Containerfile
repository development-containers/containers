FROM registry.fedoraproject.org/fedora:42

RUN dnf install -y unar

ENV NUSHELL_VERSION=0.104.0
ENV TYPST_VERSION=0.13.0
ENV ZELLIJ_VERSION=0.41.2
ENV CUELANG_VERSION=0.12.1
ENV GLEAM_VERSION=1.11.0
ENV STARSHIP_VERSION=1.23.0
ENV DENO_VERSION=2.3.5
ENV ZOLA_VERSION=0.20.0
ENV NICKEL_VERSION=1.11.0
ENV TAPLO_VERSION=0.9.3
ENV CARAPACE_VERSION=1.3.1
ENV JUJUTSU_VERSION=0.29.0
ENV CROSS_VERSION=0.2.5
ENV MPROCS_VERSION=0.7.2
ENV REBAR_VERSION=3.24.0
ENV DIOXUS_VERSION=0.6.3
ENV CARGO_AUDIT_VERSION=0.21.2

#unpack jujutsu
ADD --checksum=sha256:0b2d7ca5f77ec6b109fc5b6f9328c8d764825d3976f874c99236481f5461a8a3 https://github.com/jj-vcs/jj/releases/download/v${JUJUTSU_VERSION}/jj-v${JUJUTSU_VERSION}-x86_64-unknown-linux-musl.tar.gz /jj.tar.gz
RUN mkdir /opt/jujutsu && unar /jj.tar.gz -o /tmp/jujutsu && mv /tmp/jujutsu/**/* /opt/jujutsu

# unpack nushell
ADD --checksum=sha256:90372b5a48b048b9e91637b44b4a060646b5617b5e82d22d6ba5b5d63eaeb602 https://github.com/nushell/nushell/releases/download/${NUSHELL_VERSION}/nu-${NUSHELL_VERSION}-x86_64-unknown-linux-musl.tar.gz  /nu.tar.gz
RUN mkdir /opt/nushell && unar /nu.tar.gz -o /tmp/nu && mv /tmp/nu/**/* /opt/nushell

#unpack typst
ADD --checksum=sha256:cd1148da61d6844e62c330fc6222e988480acafe33b76daec8eb5d221258feb6 https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz  /typst.tar.xz
RUN mkdir /opt/typst && unar /typst.tar.xz -o /tmp/typst && mv /tmp/typst/**/* /opt/typst

#unpack zellij
ADD --checksum=sha256:b1c321a817d8a5baf55c2798f6ac7495bba925d686d9877e9604a50784bf6c78 https://github.com/zellij-org/zellij/releases/download/v${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz /zellij.tar.xz
RUN mkdir /opt/zellij && unar /zellij.tar.xz -o /tmp/zellij && mv /tmp/zellij/* /opt/zellij

# unpack cuelang
ADD --checksum=sha256:40ef0a84594494c953945fb297842d3168c92170694928c9565cc0b581235ac5 https://github.com/cue-lang/cue/releases/download/v${CUELANG_VERSION}/cue_v${CUELANG_VERSION}_linux_amd64.tar.gz /cue.tar.gz
RUN mkdir /opt/cuelang && unar /cue.tar.gz -o /tmp/cue && mv /tmp/cue/cue/* /opt/cuelang

# unpack gleam
ADD --checksum=sha256:19a6a100bf620686fe90a52d31569d4b0a4052ae6a270d08862019f9d3604675 https://github.com/gleam-lang/gleam/releases/download/v${GLEAM_VERSION}/gleam-v${GLEAM_VERSION}-x86_64-unknown-linux-musl.tar.gz /gleam.tar.gz
RUN mkdir /opt/gleam && unar /gleam.tar.gz -o /tmp/gleam && mv /tmp/gleam/* /opt/gleam

# unpack starship
ADD --checksum=sha256:8d06d2cc67aedd6316ff58ab679fb80cded0d85de1dcd5727df0633d35356d57 https://github.com/starship/starship/releases/download/v${STARSHIP_VERSION}/starship-x86_64-unknown-linux-musl.tar.gz /starship.tar.gz
RUN mkdir /opt/starship && unar /starship.tar.gz -o /tmp/starship && mv /tmp/starship/* /opt/starship

#unpack intelij
# TODO: uncomment once we have gui apps working
# ADD --checksum=sha256:b183b126de2cd457475eea184874b5da2fa33ba5ae2ff874bdc8c1d534156428 https://download.jetbrains.com/idea/ideaIC-2024.3.1.1.tar.gz intellij.tar.gz
# RUN mkdir /opt/intellij && unar /intellij.tar.gz -o /tmp/intellij && mv /tmp/intellij/**/* /opt/intellij

#unpack deno
ADD --checksum=sha256:096ddb8b151adb26f34ac6a8f2beb774776e4b80173824181eb2d2f81e00d111 https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip /deno.zip
RUN mkdir /opt/deno && unar /deno.zip -o /tmp/deno && mv /tmp/deno/* /opt/deno

#unpack zola
ADD --checksum=sha256:ca7ed5b33a739c5b5b35a0e207e5c3578a652cd12b61c675763b3ff34c322d08 https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz /zola.tar.gz
RUN mkdir /opt/zola && unar /zola.tar.gz -o /tmp/zola && mv /tmp/zola/* /opt/zola

#unpack nickel
ADD --checksum=sha256:d40cd32b8374636fda8939a8e479616c7a1db57acb5ef5a9621e242ed8f5a361 https://github.com/tweag/nickel/releases/download/${NICKEL_VERSION}/nickel-x86_64-linux /nickel
ADD --checksum=sha256:ddb71a410eaba865af73661ee7a902d959435c245671fbbeebeba38b82f8fc67 https://github.com/tweag/nickel/releases/download/${NICKEL_VERSION}/nls-x86_64-linux /nls
RUN mkdir /opt/nickel && mv /nls /opt/nickel/nls && chmod +x /opt/nickel/nls && mv /nickel /opt/nickel/nickel && chmod +x /opt/nickel/nickel 


#unpack taplo
ADD --checksum=sha256:889efcfa067b179fda488427d3b13ce2d679537da8b9ed8138ba415db7da2a5e https://github.com/tamasfe/taplo/releases/download/${TAPLO_VERSION}/taplo-linux-x86_64.gz /taplo.gz
RUN mkdir /opt/taplo &&  unar /taplo.gz -o /opt/taplo/ && chmod +x /opt/taplo/taplo


#unpack carapace
ADD --checksum=sha256:7d1152a064da383a2d67cb60e6e44bb09c5751c095919d00711a246099806d57 https://github.com/carapace-sh/carapace-bin/releases/download/v${CARAPACE_VERSION}/carapace-bin_${CARAPACE_VERSION}_linux_amd64.tar.gz /carapace.tar.gz
RUN mkdir /opt/carapace &&  unar /carapace.tar.gz -o /tmp/carapace/ && mv /tmp/carapace/carapace/* /opt/carapace


#unpack rebar3
ADD --checksum=sha256:d2d31cfb98904b8e4917300a75f870de12cb5167cd6214d1043e973a56668a54 https://github.com/erlang/rebar3/releases/download/${REBAR_VERSION}/rebar3 /opt/rebar3/rebar3
RUN chmod +x /opt/rebar3/rebar3

#unpack mprocs
ADD --checksum=sha256:8708b84540cbde9fcff123528a7b0a679eaf7b73bc2e070ba4b96e741ea00b03 https://github.com/pvolok/mprocs/releases/download/v${MPROCS_VERSION}/mprocs-${MPROCS_VERSION}-linux-x86_64-musl.tar.gz /mprocs.tar.gz
RUN mkdir /opt/mprocs && unar /mprocs.tar.gz -o /tmp/mprocs/ && mv /tmp/mprocs/* /opt/mprocs


#unpack cross
ADD --checksum=sha256:a486cefa6cb486971b97be321ea9dfc2e90c1979550295314a368f53fab6d588 https://github.com/cross-rs/cross/releases/download/v${CROSS_VERSION}/cross-x86_64-unknown-linux-musl.tar.gz /cross.tar.gz
RUN mkdir /opt/cross && unar /cross.tar.gz -o /tmp/cross/ && mv /tmp/cross/cross/* /opt/cross

#unpack dioxus-cli
ADD --checksum=sha256:2d2e205bad9715141019ec558e19874d3922c7803656e98ba4518c18a0e22196 https://github.com/DioxusLabs/dioxus/releases/download/v${DIOXUS_VERSION}/dx-x86_64-unknown-linux-gnu-v${DIOXUS_VERSION}.tar.gz /dioxus.tar.gz
RUN mkdir /opt/dioxus &&  unar /dioxus.tar.gz -o /opt/dioxus/

#unpack cargo-audit
ADD --checksum=sha256:5eaad156124e01d54ce937cbb2c069a8145b01e7fa29aef62bef1b386b4c1519 https://github.com/rustsec/rustsec/releases/download/cargo-audit/v${CARGO_AUDIT_VERSION}/cargo-audit-x86_64-unknown-linux-gnu-v${CARGO_AUDIT_VERSION}.tgz /cargo-audit.tar.gz
RUN mkdir /opt/cargo-audit &&  unar /cargo-audit.tar.gz -o /tmp/cargo-audit/ && mv /tmp/cargo-audit/**/* /opt/cargo-audit


#unpack cargo-chef
ENV CARGO_CHEF_VERSION=0.1.71
ADD --checksum=sha256:0ac1c3668f81dcbc8867e3ba41e939d98ff4a3f4ce1aeda795da138685618815 https://github.com/LukeMathWalker/cargo-chef/releases/download/v${CARGO_CHEF_VERSION}/cargo-chef-x86_64-unknown-linux-gnu.tar.gz /cargo-chef.tar.gz
RUN mkdir /opt/cargo-chef &&  unar /cargo-chef.tar.gz -o /tmp/cargo-chef/ && mv /tmp/cargo-chef/* /opt/cargo-chef

#get red
#ADD --checksum=sha256:625a7cbe17955022078397567c55c473ca3f8f74a54f2253e8d4ab1bccaa5c11  https://static.red-lang.org/dl/linux/red-cli-066 /tmp/red
#RUN mkdir /opt/red && mv /tmp/red /opt/red//red && chmod +x /opt/red/red
