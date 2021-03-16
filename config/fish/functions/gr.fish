function gr
    if test -e ./gradlew
        set_color blue; echo "Using gradle wrapper"
        ./gradlew $argv
    else
        gradle $argv
    end
end
