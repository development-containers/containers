# A simple fedora image for use in CI and builder scenarios
FROM quay.io/podman/stable:latest


RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
    dnf update -y && \
    dnf install -y sqlite rustup curl git rustup just ripgrep fd bash cmake nodejs skopeo \
    openssl-devel age wget g++ automake autoconf ncurses-devel unar 7z unzip tree python3 && \
    dnf clean all

# ------
COPY --link --from=opt /opt/deno /opt/deno
COPY --link --from=opt /opt/nushell /opt/nushell
COPY --link --from=opt /opt/cross /opt/cross
COPY --link --from=opt /opt/dioxus /opt/dioxus
COPY --link --from=opt /opt/cargo-audit /opt/cargo-audit
COPY --link --from=opt /opt/cargo-chef /opt/cargo-chef


ENV PATH="$PATH:/opt/deno/:/opt/nushell/:/opt/cross/:/opt/dioxus/:/opt/cargo-audit:/opt/cargo-chef"


ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH 

RUN rustup-init -y --profile minimal --component clippy rustfmt

