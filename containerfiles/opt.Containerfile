FROM registry.fedoraproject.org/fedora:43

RUN dnf install -y unar

ENV NUSHELL_VERSION=0.109.1
ENV TYPST_VERSION=0.14.0
ENV ZELLIJ_VERSION=0.41.2
ENV CUELANG_VERSION=0.15.1
ENV GLEAM_VERSION=1.13.0
ENV STARSHIP_VERSION=1.24.1
ENV DENO_VERSION=2.5.1
ENV ZOLA_VERSION=0.21.0
ENV NICKEL_VERSION=1.14.0
ENV TAPLO_VERSION=0.10.0
ENV CARAPACE_VERSION=1.5.5
ENV JUJUTSU_VERSION=0.36.0
ENV CROSS_VERSION=0.2.5
ENV MPROCS_VERSION=0.7.2
ENV REBAR_VERSION=3.24.0
ENV DIOXUS_VERSION=0.7.1
ENV CARGO_AUDIT_VERSION=0.21.2
ENV TINYMIST_VERSION=0.14.4
ENV JDTLS_VERSION=1.49.0
ENV K6_VERSION=1.4.2
ENV JUST_LSP_VERSION=0.2.7


# unpack just-lsp
ADD --checksum=sha256:998cf9a5cfa09ef832d6c3656488ffd2c714b16f509a5d9d1a36bc2b972988c3 https://github.com/terror/just-lsp/releases/download/${JUST_LSP_VERSION}/just-lsp-${JUST_LSP_VERSION}-x86_64-unknown-linux-gnu.tar.gz /just-lsp.tar.gz
RUN mkdir /opt/just-lsp &&  unar /just-lsp.tar.gz -o /tmp/just-lsp/ && mv /tmp/just-lsp/**/* /opt/just-lsp

#unpack k6
ADD --checksum=sha256:c827501f510265db9c3313e4164d2585a97c7a3485ed440b93f7b1cfe6facd28 https://github.com/grafana/k6/releases/download/v${K6_VERSION}/k6-v${K6_VERSION}-linux-amd64.tar.gz /k6.tar.gz
RUN mkdir /opt/k6 &&  unar /k6.tar.gz -o /tmp/k6/ && mv /tmp/k6/**/* /opt/k6

# unpack tinymist
ADD --checksum=sha256:746bec8140903199a39f93f4d50a5588b9e7f3c8dbcf44d13f1381a5c2740b50 https://github.com/Myriad-Dreamin/tinymist/releases/download/v${TINYMIST_VERSION}/tinymist-x86_64-unknown-linux-gnu.tar.gz /tinymist.tar.gz
RUN mkdir /opt/tinymist && unar /tinymist.tar.gz -o /tmp/tinymist && mv /tmp/tinymist/**/* /opt/tinymist

# unpack JDTLS
ADD --checksum=sha256:a3f9fb5921f5273d0f8fe4365b363fbad1bdc2e86991db3149b2d76f1265bcd7 https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/${JDTLS_VERSION}/jdt-language-server-${JDTLS_VERSION}-202507311558.tar.gz /jdtls.tar.gz
RUN mkdir /opt/jdtls && unar /jdtls.tar.gz -o /opt/jdtls

#unpack jujutsu
ADD --checksum=sha256:b9526754d35ee643dd7f91a927d0e5650563e1092ffa599765624a3f212277ab https://github.com/jj-vcs/jj/releases/download/v${JUJUTSU_VERSION}/jj-v${JUJUTSU_VERSION}-x86_64-unknown-linux-musl.tar.gz /jj.tar.gz
RUN mkdir /opt/jujutsu && unar /jj.tar.gz -o /tmp/jujutsu && mv /tmp/jujutsu/**/* /opt/jujutsu

# unpack nushell
ADD --checksum=sha256:0822ed54621fc22c0e9c446df6e709f89d07f5e50a00a025c9a0ec0cc3e7d4ee https://github.com/nushell/nushell/releases/download/${NUSHELL_VERSION}/nu-${NUSHELL_VERSION}-x86_64-unknown-linux-musl.tar.gz  /nu.tar.gz
RUN mkdir /opt/nushell && unar /nu.tar.gz -o /tmp/nu && mv /tmp/nu/**/* /opt/nushell

#unpack typst
ADD --checksum=sha256:99816d2982de08d2b091bac56b59b2faa523a10e1378ad3cdd68e35b8eb74b3d https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz  /typst.tar.xz
RUN mkdir /opt/typst && unar /typst.tar.xz -o /tmp/typst && mv /tmp/typst/**/* /opt/typst

#unpack zellij
ADD --checksum=sha256:b1c321a817d8a5baf55c2798f6ac7495bba925d686d9877e9604a50784bf6c78 https://github.com/zellij-org/zellij/releases/download/v${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz /zellij.tar.xz
RUN mkdir /opt/zellij && unar /zellij.tar.xz -o /tmp/zellij && mv /tmp/zellij/* /opt/zellij

# unpack cuelang
ADD --checksum=sha256:aa282261245e9ab0d65b17ec3c7207f5231600106f7b26fc0c2e158b3937ca3f https://github.com/cue-lang/cue/releases/download/v${CUELANG_VERSION}/cue_v${CUELANG_VERSION}_linux_amd64.tar.gz /cue.tar.gz
RUN mkdir /opt/cuelang && unar /cue.tar.gz -o /tmp/cue && mv /tmp/cue/cue/* /opt/cuelang

# unpack gleam
ADD --checksum=sha256:8b372488e5ccaa54d8acc2feb9852c9e7916e480566049edd565caa1d8c74eec https://github.com/gleam-lang/gleam/releases/download/v${GLEAM_VERSION}/gleam-v${GLEAM_VERSION}-x86_64-unknown-linux-musl.tar.gz /gleam.tar.gz
RUN mkdir /opt/gleam && unar /gleam.tar.gz -o /tmp/gleam && mv /tmp/gleam/* /opt/gleam

# unpack starship
ADD --checksum=sha256:44a729c34aea5b0451fba49108cdc5ef6b1ae68db65e7623cc244a52efcd23d1 https://github.com/starship/starship/releases/download/v${STARSHIP_VERSION}/starship-x86_64-unknown-linux-musl.tar.gz /starship.tar.gz
RUN mkdir /opt/starship && unar /starship.tar.gz -o /tmp/starship && mv /tmp/starship/* /opt/starship

#unpack intelij
# TODO: uncomment once we have gui apps working
# ADD --checksum=sha256:b183b126de2cd457475eea184874b5da2fa33ba5ae2ff874bdc8c1d534156428 https://download.jetbrains.com/idea/ideaIC-2024.3.1.1.tar.gz intellij.tar.gz
# RUN mkdir /opt/intellij && unar /intellij.tar.gz -o /tmp/intellij && mv /tmp/intellij/**/* /opt/intellij

#unpack deno
ADD --checksum=sha256:bceddde4ff520f21c3767d893fe3d2d83df788346d3ad6f03d8abcd0392eb3ab https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip /deno.zip
RUN mkdir /opt/deno && unar /deno.zip -o /tmp/deno && mv /tmp/deno/* /opt/deno

#unpack zola
ADD --checksum=sha256:5c37a8f706567d6cad3f0dbc0eaebe3b9591cc301bd67089e5ddc0d0401732d6 https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz /zola.tar.gz
RUN mkdir /opt/zola && unar /zola.tar.gz -o /tmp/zola && mv /tmp/zola/* /opt/zola

#unpack nickel
ADD --checksum=sha256:a60b39a5e294dcca52d71e3acf19c4e7358e62a724abbccb20392fed57331660 https://github.com/tweag/nickel/releases/download/${NICKEL_VERSION}/nickel-x86_64-linux /nickel
ADD --checksum=sha256:6dd187e4eaf102393870f067a47df2cf55ebb5f67ae053d3e2b83957b5bc66f5 https://github.com/tweag/nickel/releases/download/${NICKEL_VERSION}/nls-x86_64-linux /nls
RUN mkdir /opt/nickel && mv /nls /opt/nickel/nls && chmod +x /opt/nickel/nls && mv /nickel /opt/nickel/nickel && chmod +x /opt/nickel/nickel 


#unpack taplo
ADD --checksum=sha256:8fe196b894ccf9072f98d4e1013a180306e17d244830b03986ee5e8eabeb6156 https://github.com/tamasfe/taplo/releases/download/${TAPLO_VERSION}/taplo-linux-x86_64.gz /taplo.gz
RUN mkdir /opt/taplo &&  unar /taplo.gz -o /opt/taplo/ && chmod +x /opt/taplo/taplo


#unpack carapace
ADD --checksum=sha256:368ae1c53cc17289616fc7475b1208603db8ea08ab89423ad7161f5548030126 https://github.com/carapace-sh/carapace-bin/releases/download/v${CARAPACE_VERSION}/carapace-bin_${CARAPACE_VERSION}_linux_amd64.tar.gz /carapace.tar.gz
RUN mkdir /opt/carapace &&  unar /carapace.tar.gz -o /tmp/carapace/ && mv /tmp/carapace/carapace/* /opt/carapace


#unpack rebar3
ADD --checksum=sha256:d2d31cfb98904b8e4917300a75f870de12cb5167cd6214d1043e973a56668a54 https://github.com/erlang/rebar3/releases/download/${REBAR_VERSION}/rebar3 /opt/rebar3/rebar3
RUN chmod +xr /opt/rebar3/rebar3

#unpack mprocs
ADD --checksum=sha256:8708b84540cbde9fcff123528a7b0a679eaf7b73bc2e070ba4b96e741ea00b03 https://github.com/pvolok/mprocs/releases/download/v${MPROCS_VERSION}/mprocs-${MPROCS_VERSION}-linux-x86_64-musl.tar.gz /mprocs.tar.gz
RUN mkdir /opt/mprocs && unar /mprocs.tar.gz -o /tmp/mprocs/ && mv /tmp/mprocs/* /opt/mprocs


#unpack cross
ADD --checksum=sha256:a486cefa6cb486971b97be321ea9dfc2e90c1979550295314a368f53fab6d588 https://github.com/cross-rs/cross/releases/download/v${CROSS_VERSION}/cross-x86_64-unknown-linux-musl.tar.gz /cross.tar.gz
RUN mkdir /opt/cross && unar /cross.tar.gz -o /tmp/cross/ && mv /tmp/cross/cross/* /opt/cross

#unpack dioxus-cli
ADD --checksum=sha256:eae034c2ba5d6d200e843c35fccf0f3d705ea8078a1e69cdf0f064f67bec3e8c https://github.com/DioxusLabs/dioxus/releases/download/v${DIOXUS_VERSION}/dx-x86_64-unknown-linux-gnu.tar.gz /dioxus.tar.gz
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
