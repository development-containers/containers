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
| editor | vim | helix |
| web application programming | go python nodejs | rust gleam kotlin deno |
| terminal multiplexing | screen | mprocs zellij |
| task runner | make | just |
| searching | find grep | fd rg |
| documents | LaTeX | typst |
| scripting | python bash | just nushell |
