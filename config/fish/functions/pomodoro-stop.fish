function pomodoro-stop
    curl -XPOST -H 'Authorization: Bearer '(keychain-get webstep.SLACK_TOKEN) -H "Content-type: application/json; charset=utf-8" -d '{"profile": {"status_text": "","status_emoji": "","status_expiration": 0}}' 'https://slack.com/api/users.profile.set'
    curl "https://slack.com/api/dnd.endDnd?token="(keychain-get webstep.SLACK_TOKEN)
    for file in ~/src/customer/*/pomodoro-stop.fish
        eval $file
    end
end
