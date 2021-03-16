function pomodoro-start
    curl -XPOST -H 'Authorization: Bearer '(keychain-get webstep.SLACK_TOKEN) -H "Content-type: application/json; charset=utf-8" -d '{"profile": {"status_text": "Focusing ...","status_emoji": ":tomato:","status_expiration":'(date -v +26M +"%s")'}}' 'https://slack.com/api/users.profile.set'
    curl "https://slack.com/api/dnd.setSnooze?token="(keychain-get webstep.SLACK_TOKEN)"&num_minutes=26"
    for file in ~/src/customer/*/pomodoro-start.fish
                eval $file
    end
end
