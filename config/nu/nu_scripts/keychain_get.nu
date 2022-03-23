def keychain-get [key: string]
    security find-generic-password -a "$USER" -s $key -w
end
