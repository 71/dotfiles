function __ghcd_resolve_project
  echo "$HOME/Code/github.com/$argv[1]"
end

function __ghcd_is_me
  test $argv[1] = "71"
end

function __ghcd_parse_repo
  set repo (string split / (string replace -r '^https://github\.com/|\.git$' '' $argv[1]))
  if test (count $repo) -eq 1
    echo "71"
    echo $repo[1]
  else
    echo $repo[1]
    echo $repo[2]
  end
end

function ghcl --description "Clone a GitHub repository"
  set repo (__ghcd_parse_repo $argv[1])

  mkdir -p (__ghcd_resolve_project $repo[1])

  set clone_url (if __ghcd_is_me $repo[1]
    echo "git@github.com:71/$repo[2].git"
  else
    echo "https://github.com/$repo[1]/$repo[2].git"
  end)

  git clone $clone_url (__ghcd_resolve_project $repo[1]/$repo[2])
end

function ghcd --description "Change directory to a GitHub repository"
  set repo (__ghcd_parse_repo $argv[1])
  set directory (__ghcd_resolve_project $repo[1]/$repo[2])

  if not test -d $directory
    ghcl $argv[1]
  end

  cd $directory
end
