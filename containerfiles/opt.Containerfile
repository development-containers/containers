FROM registry.fedoraproject.org/fedora:41 

RUN dnf install -y unar

ENV NUSHELL_VERSION=0.101.0
ENV TYPST_VERSION=0.12.0
ENV ZELLIJ_VERSION=0.41.2
ENV CUELANG_VERSION=0.11.1
ENV GLEAM_VERSION=1.6.3
ENV STARSHIP_VERSION=1.21.1
ENV DENO_VERSION=2.1.4
ENV ZOLA_VERSION=0.19.2
ENV NICKEL_VERSION=1.9.1
ENV TAPLO_VERSION=0.9.3
ENV CARAPACE_VERSION=1.1.1
ENV JUJUTSU_VERSION=0.25.0

#unpack jujutsu
ADD --checksum=sha256:56cf8d80043bc5165919b5b47c5763f5e741313931ca07bad8443704a7ecd180 https://github.com/jj-vcs/jj/releases/download/v${JUJUTSU_VERSION}/jj-v${JUJUTSU_VERSION}-x86_64-unknown-linux-musl.tar.gz /jj.tar.gz
RUN mkdir /opt/jujutsu && unar /jj.tar.gz -o /tmp/jujutsu && mv /tmp/jujutsu/**/* /opt/jujutsu

# unpack nushell
ADD --checksum=sha256:9d316709c29777f2bdf81d455fc74c54af3bbf61038d409eb8f147931ff03762 https://github.com/nushell/nushell/releases/download/${NUSHELL_VERSION}/nu-${NUSHELL_VERSION}-x86_64-unknown-linux-musl.tar.gz  /nu.tar.gz
RUN mkdir /opt/nushell && unar /nu.tar.gz -o /tmp/nu && mv /tmp/nu/**/* /opt/nushell

#unpack typst
ADD --checksum=sha256:605130a770ebd59a4a579673079cb913a13e75985231657a71d6239a57539ec3 https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz  /typst.tar.xz
RUN mkdir /opt/typst && unar /typst.tar.xz -o /tmp/typst && mv /tmp/typst/**/* /opt/typst

#unpack zellij
ADD --checksum=sha256:b1c321a817d8a5baf55c2798f6ac7495bba925d686d9877e9604a50784bf6c78 https://github.com/zellij-org/zellij/releases/download/v${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz /zellij.tar.xz
RUN mkdir /opt/zellij && unar /zellij.tar.xz -o /tmp/zellij && mv /tmp/zellij/* /opt/zellij

# unpack cuelang
ADD --checksum=sha256:60c46ec5b90190c22a96ab3529ad363d03b687331bbeb6d7d8097a2983d7716d https://github.com/cue-lang/cue/releases/download/v${CUELANG_VERSION}/cue_v${CUELANG_VERSION}_linux_amd64.tar.gz /cue.tar.gz
RUN mkdir /opt/cuelang && unar /cue.tar.gz -o /tmp/cue && mv /tmp/cue/cue/* /opt/cuelang

# unpack gleam
ADD --checksum=sha256:db9c07b41d8aacf4cd7235efba438af1a5dadefd94f1a6e08534d247d883bc88 https://github.com/gleam-lang/gleam/releases/download/v${GLEAM_VERSION}/gleam-v${GLEAM_VERSION}-x86_64-unknown-linux-musl.tar.gz /gleam.tar.gz
RUN mkdir /opt/gleam && unar /gleam.tar.gz -o /tmp/gleam && mv /tmp/gleam/* /opt/gleam

# unpack starship
ADD --checksum=sha256:744e21eb2e61b85b0c11378520ebb9e94218de965bca5b8c2266f6c3e23ff5be https://github.com/starship/starship/releases/download/v${STARSHIP_VERSION}/starship-x86_64-unknown-linux-musl.tar.gz /starship.tar.gz
RUN mkdir /opt/starship && unar /starship.tar.gz -o /tmp/starship && mv /tmp/starship/* /opt/starship

#unpack intelij
# TODO: uncomment once we have gui apps working
# ADD --checksum=sha256:b183b126de2cd457475eea184874b5da2fa33ba5ae2ff874bdc8c1d534156428 https://download.jetbrains.com/idea/ideaIC-2024.3.1.1.tar.gz intellij.tar.gz
# RUN mkdir /opt/intellij && unar /intellij.tar.gz -o /tmp/intellij && mv /tmp/intellij/**/* /opt/intellij

#unpack deno
ADD --checksum=sha256:54a81939cccb2af114c4d0a68a554cf4a04b1f08728e70f663f83781de19d785 https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip /deno.zip
RUN mkdir /opt/deno && unar /deno.zip -o /tmp/deno && mv /tmp/deno/* /opt/deno

#unpack zola
ADD --checksum=sha256:0798e69b86c628ddcb264ebd86c8cc8dce7670b9049060bf94faa73f6857cd9c https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz /zola.tar.gz
RUN mkdir /opt/zola && unar /zola.tar.gz -o /tmp/zola && mv /tmp/zola/* /opt/zola

#unpack nickel
ADD --checksum=sha256:9b26326663c8255aec85d4e521d6ac33bb08c522433e06b80339b4aee61b8b84 https://github.com/tweag/nickel/releases/download/${NICKEL_VERSION}/nickel-x86_64-linux /nickel
RUN mkdir /opt/nickel && mv /nickel /opt/nickel/nickel && chmod +x /opt/nickel/nickel 


#unpack taplo
ADD --checksum=sha256:889efcfa067b179fda488427d3b13ce2d679537da8b9ed8138ba415db7da2a5e https://github.com/tamasfe/taplo/releases/download/${TAPLO_VERSION}/taplo-linux-x86_64.gz /taplo.gz
RUN mkdir /opt/taplo &&  unar /taplo.gz -o /opt/taplo/ && chmod +x /opt/taplo/taplo


#unpack carapace
ADD --checksum=sha256:0f716792571b318d9c86ebc8b4db6d05972ce5def5d42c8646f0ba4e899a0794 https://github.com/carapace-sh/carapace-bin/releases/download/v${CARAPACE_VERSION}/carapace-bin_1.1.1_linux_amd64.tar.gz /carapace.tar.gz
RUN mkdir /opt/carapace &&  unar /carapace.tar.gz -o /tmp/carapace/ && mv /tmp/carapace/carapace/* /opt/carapace
