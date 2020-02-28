#!/bin/bash
if [ -z $CIRCLE_PULL_REQUESTS ]; then
  if [ -z $CIRCLE_USERNAME ]; then
    m="Build <$CIRCLE_BUILD_URL|#$CIRCLE_BUILD_NUM> of <|$CIRCLE_PROJECT_REPONAME> on branch \`$CIRCLE_BRANCH\`"
  else
    m="Build <$CIRCLE_BUILD_URL|#$CIRCLE_BUILD_NUM> of <|$CIRCLE_PROJECT_REPONAME> on branch \`$CIRCLE_BRANCH\` by $CIRCLE_USERNAME"
  fi
else
  PR_NUM=$(echo $CIRCLE_PULL_REQUEST | sed 's/.*\///')

  if [ -z $CIRCLE_USERNAME ]; then
    m="Build <$CIRCLE_BUILD_URL|#$CIRCLE_BUILD_NUM> of <|$CIRCLE_PROJECT_REPONAME> on branch \`$CIRCLE_BRANCH\` in PR <$CIRCLE_PULL_REQUEST|#$PR_NUM>"
  else
    m="Build <$CIRCLE_BUILD_URL|#$CIRCLE_BUILD_NUM> of <|$CIRCLE_PROJECT_REPONAME> on branch \`$CIRCLE_BRANCH\` in PR <$CIRCLE_PULL_REQUEST|#$PR_NUM> by $CIRCLE_USERNAME"
  fi
fi

echo $m
echo "export SLACK_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
