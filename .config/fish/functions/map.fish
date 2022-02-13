function map -d "Map input lines" -S
    set -l cmd "$argv"
    set cmd (string replace -a -r '%line\b' '$$line' $cmd)
    set cmd (string replace -a -r '%_\b' '$$line' $cmd)
    set cmd (string replace -a -r '%i\b' '$$i' $cmd)

    eval """
        set -l i 0
        while read -l line; $cmd; set i (math \$i + 1); end
    """
end

complete -c map -f -a '(__fish_complete_subcommand)'

function % -w map
    map $argv
end

set line '$line'
set i '$i'
