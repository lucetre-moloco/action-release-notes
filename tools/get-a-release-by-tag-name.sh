# bash tools/get-a-release-by-tag-name.sh

OWNER=lucetre
REPO=action-release-notes
TAG=$(jq -r .[0].tag_name <tools/list-releases.json)

OUTFILE=tools/get-a-release-by-tag-name.json
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $(gh auth token)" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/releases/tags/$TAG >$OUTFILE

echo -e "┏━━━━━━━━━━━━━━━ START_OF_RELEASE_ID ━━━━━━━━━━━━━━┓"
jq .id <$OUTFILE
echo -e "┗━━━━━━━━━━━━━━━━ END_OF_RELEASE_ID ━━━━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━━━ START_OF_RELEASE_NAME ━━━━━━━━━━━━━┓"
jq .name <$OUTFILE
echo -e "┗━━━━━━━━━━━━━━━ END_OF_RELEASE_NAME ━━━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━ START_OF_RELEASE_TAG_NAME ━━━━━━━━━━━┓"
jq .tag_name <$OUTFILE
echo -e "┗━━━━━━━━━━━━━ END_OF_RELEASE_TAG_NAME ━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━ START_OF_RELEASE_HTML_URL ━━━━━━━━━━━┓"
jq .html_url <$OUTFILE
echo -e "┗━━━━━━━━━━━━━ END_OF_RELEASE_HTML_URL ━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━ START_OF_RELEASE_TARGET_COMMITISH ━━━━━━━┓"
jq .target_commitish <$OUTFILE
echo -e "┗━━━━━━━━━ END_OF_RELEASE_TARGET_COMMITISH ━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━━━━━━ START_OF_RELEASE_BODY ━━━━━━━━━━━━━┓"
jq .body <$OUTFILE
echo -e "┗━━━━━━━━━━━━━━━ END_OF_RELEASE_BODY ━━━━━━━━━━━━━━┛\n"

echo -e "┏━━━━━━━━━ START_OF_RELEASE_MENTIONS_COUNT ━━━━━━━━┓"
jq .mentions_count <$OUTFILE
echo -e "┗━━━━━━━━━━ END_OF_RELEASE_MENTIONS_COUNT ━━━━━━━━━┛\n"
