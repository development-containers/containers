repo := "ghcr.io/development-containers"


_default:
    @just --list

build-alpine: (_build "alpine")


_run name:
    docker run --rm -it {{repo}}/{{name}}

_build name:
     docker build -t {{repo}}/{{name}} -f containerfiles/{{name}}.Containerfile .

_push name:
    docker push {{repo}}/{{name}}