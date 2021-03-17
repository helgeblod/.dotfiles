function bb "Install homebrew package and add to Brewfile"
    set --local options 'h/help' 'c/cask=' 'r/repo='
    argparse -x $options -- $argv
    if set --query _flag_help
        printf "Usage: bbi [OPTIONS]\n\n"
        printf "Options:\n"
        printf "  -h/--help       Prints help and exits\n"
        printf "  -c/--cask       Install cask\n"
        printf "  -s/--search     Search brew "
        return 0
    end

    set --query _flag_cask; or set --local _flag_cask ''
    set --query _flag_search; or set --local _flag_search ''
    if [ $_flag_cask != "master" ]
        git checkout -b "sync"/$_flag_repo/$_flag_branch
    end
    git merge --strategy recursive --strategy-option subtree=$_flag_repo/ $_flag_repo/$_flag_branch
    git push
    if [ $_flag_branch != "master" ]
        git checkout -
        git branch -D $_flag_repo/$_flag_branch
    end
    echo "🌱 '"$_flag_branch"' in 🗄 "$_flag_repo" > 🌱 'sync/"$_flag_repo"/"$_flag_branch"'' in 🗄 memoro-mono"
    echo "monorepo 🎋 "$_flag_branch" is in sync with 🗄  "$_flag_repo" ✅"
    cd $origin_dir
end



    for file in ~/src/customer/*/.Brewfile
        # Install homebrew packages from Customer drives
        brew bundle --file $file
    end
end
