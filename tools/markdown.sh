# bash tools/markdown.sh

MARKDOWN_TEXT="$(jq .[0].body <tools/list-releases.json)"
MARKDOWN_JSON=$(jq -n --arg text "$MARKDOWN_TEXT" '{"text": $text}')

OUTFILE=tools/markdown.html
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $(gh auth token)" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/markdown \
  --data "$MARKDOWN_JSON" >$OUTFILE

echo -e "┏━━━━━━━━━━━━━━━ START_OF_RELEASE_BODY_HTML ━━━━━━━━━━━━━━┓"
cat $OUTFILE
echo -e "┗━━━━━━━━━━━━━━━━ END_OF_RELEASE_BODY_HTML ━━━━━━━━━━━━━━━┛\n"
