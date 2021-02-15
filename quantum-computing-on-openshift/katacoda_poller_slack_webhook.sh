#!/bin/bash
# Run this in your katacoda scenario git repo: https://www.katacoda.community/
# Requires setup of Incoming Webhook on Slack: https://api.slack.com/messaging/webhooks

SCENARIO_URL='https://katacoda.com/husky-parul/courses/quantum-computing-on-openshift' 
SLACK_WEBHOOK_URL='https://hooks.slack.com/services/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'

commit_id=`git log --pretty=format:'%H' -n 1`

echo "Checking if scenario has been updated on Katacoda.."
until curl -s $SCENARIO_URL | grep $commit_id  > /dev/null 2>&1
do
  sleep 1
done

curl -X POST --data-urlencode "payload={\"text\": \"Hey @<USER> Katacoda env Ready\", \"channel\": \"team-dev\", \"link_names\": \"1\"}" $SLACK_WEBHOOK_URL
