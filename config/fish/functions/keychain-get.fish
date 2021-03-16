function keychain-get
    security find-generic-password -a "$USER" -s $argv[1] -w
end
