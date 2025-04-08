# A simple fedora image for use in CI and builder scenarios
FROM quay.io/podman/stable:latest


RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
    dnf update -y && \
    dnf install -y sqlite rustup curl git rustup just ripgrep fd bash cmake nodejs skopeo \
    openssl-devel age wget g++ automake autoconf ncurses-devel unar 7z unzip tree python3 && \
    dnf clean all

# ------
COPY --from=opt /opt/deno /opt/deno
COPY --from=opt /opt/nushell /opt/nushell
COPY --from=opt /opt/cross /opt/cross
COPY --from=opt /opt/dioxus /opt/dioxus
COPY --from=opt /opt/cargo-audit /opt/cargo-audit

ENV PATH="$PATH:/opt/deno/:/opt/nushell/:/opt/cross/:/opt/dioxus/:/opt/cargo-audit"


ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH 

RUN rustup-init -y --profile minimal --component clippy rustfmt
RUN cargo install cargo-chef --locked --version 0.1.71

