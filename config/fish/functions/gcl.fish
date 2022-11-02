function gcl
    git cleanup
    gum style "Select branches to delete:"
    git branch -vv | grep gone | cut -d' ' -f3 | gum choose --no-limit | xargs git branch -D
end
