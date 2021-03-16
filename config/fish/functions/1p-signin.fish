function 1p-signin
    op get account > /dev/null;and echo "1p account signed in ✨";or eval (op signin)
end
