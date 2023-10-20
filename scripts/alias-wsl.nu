if not ($env | get -i WSL | default false) {
  return
}
alias explorer = ^(find_in_win_path explorer.exe)
alias cmd = ^(find_in_win_path cmd.exe)
alias powershell = ^(find_in_win_path powershell.exe)
alias clip = ^(find_in_win_path clip.exe)
alias notepad = ^(find_in_win_path notepad.exe)
alias wt = ^(find_in_win_path wt.exe)
alias gitk = ^(find_in_win_path gitk.exe)
alias ipconfig.exe = ^(find_in_win_path ipconfig.exe)

def ver [] {
  cd /mnt/c
  cmd.exe /c ver
}
