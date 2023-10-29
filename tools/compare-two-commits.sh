# bash tools/compare-two-commits.sh

OWNER=lucetre
REPO=action-release-notes

AFTER_TAG_NAME=$(jq -r .[0].tag_name <tools/list-releases.json)
BEFORE_TAG_NAME=$(jq -r .[1].tag_name <tools/list-releases.json)
BASEHEAD="$BEFORE_TAG_NAME...$AFTER_TAG_NAME"

OUTFILE=tools/compare-two-commits.json
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $(gh auth token)" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/compare/$BASEHEAD >$OUTFILE

echo -e "┏━━━━━━━━━━━━━ START_OF_COMPARE_STATUS ━━━━━━━━━━━━┓"
jq .status <$OUTFILE
echo -e "┗━━━━━━━━━━━━━━ END_OF_COMPARE_STATUS ━━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━ START_OF_COMPARE_AHEAD_BY ━━━━━━━━━━━┓"
jq .ahead_by <$OUTFILE
echo -e "┗━━━━━━━━━━━━━ END_OF_COMPARE_AHEAD_BY ━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━ START_OF_COMPARE_BEHIND_BY ━━━━━━━━━━━┓"
jq .behind_by <$OUTFILE
echo -e "┗━━━━━━━━━━━━ END_OF_COMPARE_BEHIND_BY ━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━ START_OF_COMPARE_TOTAL_COMMITS ━━━━━━━━━┓"
jq .total_commits <$OUTFILE
echo -e "┗━━━━━━━━━━ END_OF_COMPARE_TOTAL_COMMITS ━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━ START_OF_COMPARE_HTML_URL ━━━━━━━━━━━┓"
jq .html_url <$OUTFILE
echo -e "┗━━━━━━━━━━━━━ END_OF_COMPARE_HTML_URL ━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━ START_OF_COMPARE_COMMITS ━━━━━━━━━━━━┓"
jq '.commits[] | "[" + .sha + "] " + .commit.message' <$OUTFILE
echo -e "┗━━━━━━━━━━━━━ END_OF_COMPARE_COMMITS ━━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━ START_OF_COMPARE_COMMIT_AUTHORS ━━━━━━━━━┓"
jq '.commits[].author | "[" + .login + "](" + .avatar_url + ")"' <$OUTFILE
echo -e "┗━━━━━━━━━ END_OF_COMPARE_COMMIT_AUTHORS ━━━━━━━━━━┛\n"
