function bbc
    for file in ~/src/customer/*/.Brewfile
        # Install homebrew packages from Customer drives
        brew bundle --file $file
    end
end
