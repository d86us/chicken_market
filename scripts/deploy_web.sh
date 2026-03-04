#!/bin/bash
set -e

echo "Building Flutter web..."
flutter build web --release --base-href /chicken_market/

echo "Deploying to GitHub Pages..."

# Create a temporary directory outside the project
TEMP_DIR=$(mktemp -d)
cp -r build/web/* "$TEMP_DIR/"

cd "$TEMP_DIR"

git init
git checkout --orphan gh-pages

git add -A
git commit -m "Deploy to GitHub Pages: $(date)" 2>/dev/null || echo "No changes to deploy"
git push origin gh-pages:gh-pages --force

# Cleanup
cd -
rm -rf "$TEMP_DIR"

echo "Deployed! Visit https://d86us.github.io/chicken_market/"
