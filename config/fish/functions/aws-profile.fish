function aws-profile
    if count $argv > /dev/null
        set -xg AWS_PROFILE $argv
        echo "AWS-profile changed"
    end
    echo "AWS-profile is: $AWS_PROFILE"
end
