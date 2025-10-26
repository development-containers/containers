repo := "ghcr.io/development-containers"
podman := `bash -c ' [[ "$(podman --version)" =~ ^[a-zA-Z[:space:]]+[5-9].*$ ]] && echo "podman" || echo "docker"'`

warn := if podman != "podman" {`echo "WARNING: Yikes! That's an old OLD operating system you go there. Please upgrade to something wiht podman 5. Falling back to docker." >&2`} else {""}

_default:
    @just --list


_run name:
    {{podman}} run --rm -it {{repo}}/{{name}}

# Build the container that has all our custom software in /opt
_build_opt:
     {{podman}} build -t opt -f containerfiles/opt.Containerfile .

build_fedora:
    just _build_opt 
    just _build fedora

build_ci_fedora:
    just _build_opt 
    just _build ci-fedora

build_alpine:
    just _build alpine 


_build name: 
     {{podman}} build -t {{repo}}/{{name}} -f containerfiles/{{name}}.Containerfile .

_push name:
    {{podman}} push {{repo}}/{{name}}


build_and_push_alpine: (build_alpine) (_test "alpine") (_push "alpine")
build_and_push_fedora: (build_fedora) (_test "fedora") (_push "feodra")
build_and_push_ci_fedora: (build_ci_fedora) (_push "ci-fedora")


# build and enter a container
try_feodra: (build_fedora) (_run "fedora")
try_alpine: (build_alpine) (_run "alpine")

# run a command in a new container
_run_command name cmd:
    {{podman}} run --entrypoint 'bash' --rm {{repo}}/{{name}} -l -c '{{cmd}}'

# build image and run some smoketests against it
_test name: (_run_command name 'set -xeuo pipefail; for script in /examples/tests/*; do "$script"; done') 

# clean up docker cache
clear_docker_cache:
    docker image prune -f
    docker builder prune -f

# fix podman on github codespaces
# on codespaces the boot id changes somtimes
reset_podman:
    rm -r /run/containers/storage
    rm -r /run/libpod
