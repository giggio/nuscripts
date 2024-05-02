alias explorer = ^(find_in_win_path explorer.exe)
alias cmd = ^(cd /mnt/c;$env.COMSPEC)
alias powershell = ^(find_in_win_path powershell.exe)
alias clip = ^(find_in_win_path clip.exe)
alias notepad = ^(find_in_win_path notepad.exe)
alias wt = ^(find_in_win_path wt.exe)
alias gitk = ^(find_in_win_path gitk.exe)
alias ipconfig = ^(find_in_win_path ipconfig.exe)
alias code = ^(find_in_win_path code)
alias code-insiders = ^(find_in_win_path code-insiders)

def ver [] {
  cmd /c ver
}
