export def-env "path get" [] {
  let path_name = if "PATH" in $env { "PATH" } else { "Path" }
  $env | get $path_name
}
