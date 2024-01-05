if not ($env | get -i WSL | default false) {
  return
}

$env.COMSPEC = /mnt/c/Windows/System32/cmd.exe

def win_path [--windows_format] {
  cd /mnt/c
  let path = (^$env.COMSPEC /c echo %PATH%)
  if ($windows_format) {
    return $path
  }
  return ($path | split row ';' | each { |p| return (wslpath $p) } | str join (char esep))
}

def find_in_win_path [exec] {
  cd /mnt/c
  let path = (^$env.COMSPEC /c $"where.exe ($exec) 2> NUL" | lines | take 1 | get 0 -i)
  if ($path != null and $path != '') {
    return (wslpath $path)
  }
  return null
}

def remove_win_from_path [] {
  let drive_mounts = (ls /mnt | where name =~ \/mnt\/[a-z]$ | get name)
  mut path = ($env.PATH | split row (char esep))
  for drive_mount in $drive_mounts {
    $path = ($path | where ($it !~ $drive_mount))
  }
  return $path
}

$env.PATH_WITH_WINDOWS = $env.PATH
$env.PATH = (remove_win_from_path)
