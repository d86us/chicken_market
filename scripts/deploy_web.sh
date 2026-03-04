#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
TEMP_DIR="$PROJECT_DIR/.gh-pages-deploy"
LOG_FILE="$PROJECT_DIR/deploy.log"

(
  set -e

  echo "Building Flutter web app..." >> "$LOG_FILE"

  cd "$PROJECT_DIR"
  flutter build web --release >> "$LOG_FILE" 2>&1

  echo "Deploying to GitHub Pages..." >> "$LOG_FILE"

  rm -rf "$TEMP_DIR"
  mkdir -p "$TEMP_DIR"

  cp -r "$PROJECT_DIR/build/web/"* "$TEMP_DIR/"

  cd "$TEMP_DIR"

  git init
  git checkout -b gh-pages

  git add -A
  git commit -m "Deploy to GitHub Pages"

  git push -f origin gh-pages

  cd "$PROJECT_DIR"
  rm -rf "$TEMP_DIR"

  echo "Done! Your site is live at: https://d86us.github.io/chicken_market/" >> "$LOG_FILE"
) &

echo "Deploy started in background. PID: $!"
echo "Check progress with: tail -f deploy.log"
