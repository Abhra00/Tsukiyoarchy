#!/usr/bin/env bash
set -e

echo "==> Checking for largest files in repo history..."
git rev-list --objects --all \
  | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
  | grep blob \
  | sort -k3 -n \
  | tail -20 \
  | numfmt --to=iec-i --field=3

echo
echo "==> Enter the path(s) of the file(s) you want to delete from history (separated by spaces):"
read -r files

if [ -z "$files" ]; then
  echo "No files provided. Exiting."
  exit 1
fi

echo
echo "==> Rewriting history to remove: $files"
git filter-repo $(for f in $files; do echo --path "$f" --invert-paths; done)

echo
echo "==> Running aggressive cleanup..."
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo
echo "==> Done! Now force push to remote:"
echo "   git push origin --force --all"
echo "   git push origin --force --tags"

