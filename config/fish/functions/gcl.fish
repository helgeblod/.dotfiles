function gcl
    git cleanup
    set branches (git branch -vv | grep gone | cut -d' ' -f3)
    for branch in $branches
        echo $branch
        read -l -P 'Do you want to delete local '$branch' (no remotes found)? [y/N] ' confirm
        switch $confirm
            case Y y
                git branch -D $branch
            case '' N n
                echo "Kept "$branch
        end
    end
end
