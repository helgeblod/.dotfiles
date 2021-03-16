function cd
    if count $argv > /dev/null
        if test -d $argv
            builtin cd "$argv"
        else
            z $argv
        end
    else
        builtin cd
    end
end
