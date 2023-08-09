if not ($env | get -i WSL | default false) {
  return
}
alias explorer = explorer.exe
alias cmd = cmd.exe
alias powershell = powershell.exe
alias clip = clip.exe
alias notepad = notepad.exe
alias wt = wt.exe
alias gitk = gitk.exe

def ver [] {
  cd /mnt/c
  cmd.exe /c ver
}
