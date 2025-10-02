#!/usr/bin/env bash

CURRENT_VERSION="$(jq -r '.version' package.json)"
echo "$CURRENT_VERSION"

IFS='.' read -r major minor patch <<< "$CURRENT_VERSION"

minor=$((minor + 1))
NEXT_VERSION="${major}.${minor}.${patch}"

# Create release branch
git checkout -b "release/v${CURRENT_VERSION}"
git push -u origin HEAD --no-verify

# bump develop version
git checkout develop && git checkout -b chore/update-version-"$NEXT_VERSION"
npm version --no-git-tag-version "$NEXT_VERSION"
git add package.json package-lock.json && git commit -m "Update version to $NEXT_VERSION"
git push -u origin HEAD --no-verify

# Create PR
current_branch=$(git rev-parse --abbrev-ref HEAD)
title=$(git branch --show-current)
PR_BODY="Update version to $CURRENT_VERSION"

gh pr create --base "develop" --head "$current_branch" --title="$title" --body "$PR_BODY"
gh pr view --web
