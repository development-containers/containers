# Try the dev setup of the future

Do you want to have a linux dev setup like everybody else will only have in 10 years?
Here you go:

```
podman run --pull=always --rm -it ghcr.io/development-containers/fedora:latest
```

or if you are on a legacy operating system replace `podman`  with `docker` in the command above.

This repo contains containerfile for contains with all the devtools you
need. 


## Synopsis

A modern dev setup uses the right tools.
For an example see this table:


| Scope    | Legacy Technology    | Modern Replacement |
| ------------- | ------------- | --- |
| Editor | (neo)vim emacs | helix |
| Web application programming | go python nodejs | rust gleam kotlin deno |
| Terminal multiplexing | screen tmux | mprocs zellij |
| Task runner | make | just |
| Searching | find grep | fd rg |
| Documents | LaTeX | typst |
| Scripting | python bash | just nushell |
| Version control | git | pijul jj |
| Containerization | docker | podman |
