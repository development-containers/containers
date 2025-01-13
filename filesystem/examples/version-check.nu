#!/usr/bin/env nu




def latest_version (proj: string): string {
    http get "https://api.github.com/repos/($proj)/releases/latest" | get tag_name
}



latest_version 'gleam-lang/gleam'