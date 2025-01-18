#!/usr/bin/env nu




def github_version (proj: string) : any -> string {
    print $"Fetching latest version from github for ($proj)"
    sleep 5sec
    http get $"https://api.github.com/repos/($proj)/releases/latest" | get tag_name | str trim --left --char=v
}


def filter_version () : string -> string {
  grep -oP '([0-9]+)\.([0-9]+)(.[0-9]+)?'
}

def get_local_version (cmd: string) : any -> string {
    try {
        run-external $cmd '--version' | lines | first | filter_version
    } catch { |err|
        print $"Running ($cmd) failed: ($err.msg)"
        "error"
    }
}


def x (user: string, repo: string) : any -> record {
    {program: $repo, local: (get_local_version $repo), latest: (github_version $"($user)/($repo)") }
}

let versions1 = [
    [ program     local                         latest]; 
    [ nushell     (get_local_version 'nu')      (github_version 'nushell/nushell')]
    [ cue     (cue version | lines | first | filter_version)      (github_version 'cue-lang/cue')]
]

let versions2 = [
    (x gleam-lang gleam)
    (x casey just)
    (x typst typst)
    (x zellij-org zellij)
    (x starship starship)
    (x denoland deno)
    (x getzola zola)
    (x jj-vcs jj)
]


# todo rg fd bat

let versions = $versions1 | append $versions2



print ($versions | insert is_up_to_date { |row| $row.local == $row.latest })