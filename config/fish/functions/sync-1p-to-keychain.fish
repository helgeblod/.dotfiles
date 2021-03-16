function sync-1p-to-keychain
    1p-signin
    for item in (op list items --tags sync-to-keychain | jq '.[] | .uuid' | tr -d '"')
        set data (op get item $item --fields title,password)
        set id (echo $data | jq '.title' | tr -d '"')
        set pw (echo $data | jq '.password' | tr -d '"')
        echo "Copying: $id to 🔐"
        security add-generic-password -U -a "$USER" -l "1password."$id -s $id -w $pw
    end
    echo "Done 🎉"
end
