# bash tools/list-releases.sh

OWNER=lucetre
REPO=action-release-notes

OUTFILE=tools/list-releases.json
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $(gh auth token)" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/releases >$OUTFILE

echo -e "┏━━━━━━━━━━━━━━━ START_OF_RELEASE_ID ━━━━━━━━━━━━━━┓"
jq .[0].id <$OUTFILE
echo -e "┗━━━━━━━━━━━━━━━━ END_OF_RELEASE_ID ━━━━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━━━ START_OF_RELEASE_NAME ━━━━━━━━━━━━━┓"
jq .[0].name <$OUTFILE
echo -e "┗━━━━━━━━━━━━━━━ END_OF_RELEASE_NAME ━━━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━ START_OF_RELEASE_TAG_NAME ━━━━━━━━━━━┓"
jq .[0].tag_name <$OUTFILE
echo -e "┗━━━━━━━━━━━━━ END_OF_RELEASE_TAG_NAME ━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━ START_OF_RELEASE_HTML_URL ━━━━━━━━━━━┓"
jq .[0].html_url <$OUTFILE
echo -e "┗━━━━━━━━━━━━━ END_OF_RELEASE_HTML_URL ━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━ START_OF_RELEASE_TARGET_COMMITISH ━━━━━━━┓"
jq .[0].target_commitish <$OUTFILE
echo -e "┗━━━━━━━━━ END_OF_RELEASE_TARGET_COMMITISH ━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━━━ START_OF_RELEASE_BODY ━━━━━━━━━━━━━┓"
jq .[0].body <$OUTFILE
echo -e "┗━━━━━━━━━━━━━━━ END_OF_RELEASE_BODY ━━━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━ START_OF_RELEASE_MENTIONS_COUNT ━━━━━━━━┓"
jq .[0].mentions_count <$OUTFILE
echo -e "┗━━━━━━━━━━ END_OF_RELEASE_MENTIONS_COUNT ━━━━━━━━━┛\n"
