# as per https://fishshell.com/docs/3.7/interactive.html#abbreviations

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

abbr --add dotdot --regex '^\.\.+$' --function multicd
