alias k = kubectl
alias st = git status
alias push = git push
alias pushf = git push --force-with-lease
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
alias grep = grep --color=auto
alias fgrep = fgrep --color=auto
alias egrep = egrep --color=auto
# alias ll = if (which eza | is-empty) { ls -la } else { eza --long --group --all --all --group-directories-first }
alias ll = eza --long --group --all --all --group-directories-first --hyperlink
alias l = ls
alias cls = clear
alias istio = istioctl
alias tf = terraform
alias cd- = cd -
alias cd.. = cd ..
alias cd... = cd ...
alias cd.... = cd ....
alias weather = curl -s wttr.in
# if not (which bat | is-empty) {
#   alias toyaml = bat --language yaml
# }
alias toyaml = bat --language yaml
# if not (which hub | is-empty) {
#   alias git = hub
# }
alias git = hub

def pushsync [] {
  git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
}

def add [...args] {
  # flags don't work. See: https://github.com/nushell/nushell/issues/3276
  if ($args | is-empty) {
    git add -A :/
  } else {
    git add ...$args
  }
}

alias mg = kitty +kitten hyperlinked_grep --smart-case

alias hm = home-manager --flake ~/.dotfiles/config/home-manager --impure
