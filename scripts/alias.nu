alias k = kubectl
alias st = git status
alias push = git push
alias pull = git pull
alias log = git log
alias ci = git commit
alias co = git checkout
alias dif = git diff
alias rs = git reset
alias rb = git rebase
alias fixup = git fixup
alias branch = git branch
alias tag = git tag
alias up = git up
alias sync = git sync
alias ccat = pygmentize -g -O style=vs -f console16m
alias ll = ls -la
alias l = ls
alias cls = clear
alias istio = istioctl
alias tf = terraform
alias cd- = cd -
alias cd.. = cd ..
alias cd... = cd ...
alias cd.... = cd ....
alias weather = curl -s wttr.in
# aliases don't persist in conditionals: https://github.com/nushell/nushell/issues/5068
# if ((which bat | is-empty) and (not (which batcat | is-empty))) {
#   alias bat = batcat
# }
alias bat = ^(if (which ^bat | is-empty) and (not (which ^batcat | is-empty)) { (which ^batcat).path | get 0 } else { (which ^bat).path | get 0 })
# if not (which bat | is-empty) {
#   alias toyaml = bat --language yaml
# }
alias toyaml = bat --language yaml
# if not (which hub | is-empty) {
#   alias git = hub
# }
alias git = hub

alias nn = ^($env.HOME | path join bin n)

def pushsync [] {
  git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
}

def add [...args] {
  # flags don't work. See: https://github.com/nushell/nushell/issues/3276
  if ($args | is-empty) {
    git add -A :/
  } else {
    git add $args
  }
}
