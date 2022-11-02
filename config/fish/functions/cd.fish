function cd
    if count $argv > /dev/null
        if test -d $argv
            builtin cd "$argv"
        else
            ji $argv
        end
    else
        builtin cd
    end
    echo "📂 PWD:" (pwd)
    echo ""
    ls
end
