#!/usr/bin/env fish

function move-last-download -d "Move last downloaded file to current folder"
    mv ~/Downloads/(ls -t -A ~/Downloads/ | head -1) .
end
