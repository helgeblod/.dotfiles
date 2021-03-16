function 1p-item-to-keychain
    echo "Copying item to 🔑"
    1p-signin;and store-password-in-keychain $argv[2] (op get item $argv[1] --fields password); or echo "Copying to keychain failed 💔"
end
