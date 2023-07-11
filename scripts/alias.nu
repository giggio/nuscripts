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
alias git = hub

def pushsync [] {
  git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
}
