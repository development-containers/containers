repo := "ghcr.io/development-containers"


_default:
    @just --list


_run name:
    docker run --rm -it {{repo}}/{{name}}

# Build the container that has all our custom software in /opt
_build_opt:
     docker build -t opt -f containerfiles/opt.Containerfile .

_build name: (_build_opt)
     docker build -t {{repo}}/{{name}} -f containerfiles/{{name}}.Containerfile .

_push name:
    docker push {{repo}}/{{name}}


build_and_push name: (_build name) (test name) (_push name)


# build and enter a container
try name: (_build name) (_run name)


# run a command in a new docker container
_run_command name cmd:
    docker run --entrypoint 'nu' --rm {{repo}}/{{name}} -c '{{cmd}}'

# build image and run some smoketests against it
test name: (_build name) (_run_command name 'cd /examples/kotlin-example-project; ./gradlew build') (_run_command name 'cd /examples; cargo new test-project; cd test-project; cargo run') (_run_command name '/examples/version-check.nu')


# clean up docker cache
clear_docker_cache:
    docker image prune -f
    docker builder prune -f

test-podman:
    mkdir -p ~/.config/containers
    printf '[storage]\ndriver="overlay"\nrootless_storage_path="/tmp/storage"\n' > ~/.config/containers/storage.conf
