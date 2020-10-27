#!/bin/bash

args="$*"
event_name=$(echo "$args" | grep -o 'event_name=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#') # 'true' or 'false'
github_repo=$(echo "$args" | grep -o 'github_repo=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
actions_run_id=$(echo "$args" | grep -o 'actions_run_id=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
github_actor=$(echo "$args" | grep -o 'github_actor=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
github_ref=$(echo "$args" | grep -o 'github_ref=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
head_ref=$(echo "$args" | grep -o 'head_ref=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
build_url="https://github.com/$github_repo/actions/runs/$actions_run_id"

echo "deploy_message=Deploy to GitHub Pages was *skipped*" >> $GITHUB_ENV

if [[ $github_ref == 'refs/pull'* ]]; then # this is a pull request
  pull_id=$(echo $github_ref | sed -E 's|refs/pull/||' | sed -E 's|/merge||')
  pull_url="https://github.com/$github_repo/pull/$pull_id"
  build_message_addition=" in PR <$pull_url|#$pull_id>"
  branch=$(echo $head_ref | sed -E 's|refs/[a-zA-Z]+/||')
else
  build_message_addition=""
  branch=$(echo $github_ref | sed -E 's|refs/[a-zA-Z]+/||')
fi

echo "branch=$branch" >> $GITHUB_ENV
echo "build_message=Build <$build_url|$actions_run_id> on branch \`$branch\`$build_message_addition" >> $GITHUB_ENV

if [[ $event_name == "schedule" ]]; then # this is a cron
  echo "actor_name=github-actions[bot]" >> $GITHUB_ENV
  echo "actor_icon=https://i.imgur.com/kUxzV44s.png" >> $GITHUB_ENV
else
  echo "actor_name=$github_actor" >> $GITHUB_ENV

  if [[ $github_actor == "pr-scheduler[bot]" ]]; then
    echo "actor_icon=https://i.imgur.com/tmdeggv.png" >> $GITHUB_ENV
  else
    echo "actor_icon=https://github.com/$github_actor.png" >> $GITHUB_ENV
  fi
fi
