function cd
    if count $argv > /dev/null
        if test -d $argv
            builtin cd "$argv"
        else
            zi $argv
        end
    else
        builtin cd
    end
end
