# Searches the history.
def 'history search' [
  str: string = '' # search string
  --cwd(-c) # Filter search result by directory
  --exit(-e): int = 0 # Filter search result by exit code
  --before(-b): datetime = 2100-01-01 #  Only include results added before this date
  --after(-a): datetime = 1970-01-01 # Only include results after this date
  --limit(-l): int = 20 # How many entries to return at most
  ] {
  history --long
  | where start_timestamp != ""
  | update start_timestamp {|r| $r.start_timestamp | into datetime}
  # | where command =~ $str and ($cwd == false or cwd == $env.PWD) and exit_status == $exit and start_timestamp > $after and start_timestamp < $before
  | where { |row| $row.command =~ $str and ($cwd == false or $row.cwd == $env.PWD) and $row.exit_status == $exit and $row.start_timestamp > $after and $row.start_timestamp < $before }
  | first $limit
  | select item_id command start_timestamp cwd duration exit_status
}

# Deletes a history entry.
def 'history delete' [
  id: int = 0 # the id of the history entry to delete
  --last # delete the last entry, ignore the id, if passed
  ] {
  if $last {
    open $nu.history-path | query db $"delete from history where id = \(select id from \(select id from history where session_id = (history session) order by id desc LIMIT 2) order by id asc LIMIT 1)"
  } else {
    if $id == 0 {
      echo "You must pass an id or use --last"
      exit 1
    }
    open $nu.history-path | query db $"delete from history where id = ($id)"
  }
  null
}

# todo: can't add to history in nushell, see: https://github.com/nushell/nushell/issues/11588

# Inserts a history entry.
def 'history insert' [
  command: string # the command to insert
  --duration(-d): int = 0 # the duration of the command
  --exit_status(-e): int = 0 # the exit status of the command
  ] {
  let now = (date now | into int)
  let diff = ($now | into string | str length) - 13 # 13 is the length of the timestamp in the database
  let adjusted_now = ($now / (10 ** $diff)) | math round
  open $nu.history-path | query db $"INSERT INTO history \(command_line, start_timestamp, session_id, hostname, cwd, duration_ms, exit_status) VALUES \('($command | sqlite_escape)', ($adjusted_now), (history session), '((sys).host.hostname | sqlite_escape)', '(pwd | sqlite_escape)', ($duration), ($exit_status))"
  null
}

def sqlite_escape [] {
  # todo: remove escaping when fixed: https://github.com/nushell/nushell/issues/11643
  $in | str replace "'" "''" --all
}
