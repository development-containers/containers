# The dev setup of the furure

Do you want to have a linux dev setup like everybody else will only have in 10 years?
Here you go:

```
podman run --pull=always --rm -it ghcr.io/development-containers/alpine:latest
```

or if you are on a legacy operating system:

```
docker run --pull=always --rm -it ghcr.io/development-containers/alpine:latest
```

This repo contains containerfile for contains with all the devtools you
need. 


## Synopsis

A modern dev setup uses the right tools.
For an example see this table:


| Scope    | Legacy Technology    | Modern Replacement |
| ------------- | ------------- | --- |
| editor | vim | helix |
| web application programming | go python nodejs | rust gleam kotlin deno |
| terminal multiplexing | screen | mprocs zellij |
| task runner | make | just |
| searching | find grep | fd rg |
| documents | LaTeX | typst |
| scripting | python bash | just nushell |


## Provided tools
### Programming languages
- rust (inc. rustup and rust-analyzer)
- nushell
- python
- gleam
- deno

### VCS Tools
- git
- pijul
- difftastic

### CLI tools
- just
- zellij
- unar
- fd
- ripgrep
- bottom
- mprocs

### Editors
- helix

### Documentation tools
- typst