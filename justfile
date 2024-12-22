repo := "ghcr.io/development-containers"


_default:
    @just --list


_run name:
    docker run --rm -it {{repo}}/{{name}}

_build name:
     docker build -t {{repo}}/{{name}} -f containerfiles/{{name}}.Containerfile .

_push name:
    docker push {{repo}}/{{name}}


_build_and_push name: (_build name) (_push name)


# build and enter a container
test name: (_build name) (_run name)

ci: (_build_and_push "alpine") (_build_and_push "ubuntu")


# clean up docker cache
clear_docker_cache:
    docker image prune -f
    docker builder prune -f