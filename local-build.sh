#!/bin/bash
set -e

### PATHS
SITE_DIR="$HOME/Code/BoringOps/boringops-hq.github.io"
MANIFESTO_DIR="$HOME/Code/BoringOps/boringops-manifesto"
ARTICLES_DIR="$HOME/Code/BoringOps/boringops-articles"
DRAFTS_DIR="$HOME/Code/BoringOps/boringops-drafts"
# New path for the build output
BUILD_DIR="$SITE_DIR/_site"
# New persistent path for the development Chrome profile
DEV_PROFILE_DIR="$HOME/Code/BoringOps/boringops-local/chrome_profile"

echo "----------------------------------------"
echo " CLEANING BUILD OUTPUT"
echo "----------------------------------------"
rm -rf "$BUILD_DIR"

echo "----------------------------------------"
echo " SYNCING CONTENT INTO REAL SITE REPO"
echo "----------------------------------------"

mkdir -p "$SITE_DIR/_includes"
mkdir -p "$SITE_DIR/_posts"

# Remove existing symlinks/files if they exist
rm -f "$SITE_DIR/_includes/MANIFESTO.md"
rm -f "$SITE_DIR/_posts/"*.md 2>/dev/null || true

# Create symlink for manifesto
ln -s "$MANIFESTO_DIR/MANIFESTO.md" "$SITE_DIR/_includes/MANIFESTO.md"

# Create symlinks for articles
for article in "$ARTICLES_DIR/articles/"*.md; do
  [ -f "$article" ] && ln -s "$article" "$SITE_DIR/_posts/$(basename "$article")"
done

# Create symlinks for articles
for article in "$DRAFTS_DIR/sh/articles/"*.md; do
  [ -f "$article" ] && ln -s "$article" "$SITE_DIR/_posts/$(basename "$article")"
done

echo "----------------------------------------"
echo " GENERATING GEMFILE"
echo "----------------------------------------"

cat > "$SITE_DIR/Gemfile" <<'GEMS'
source "https://rubygems.org"

gem "jekyll", "~> 4.3"
gem "minimal-mistakes-jekyll"
gem "jekyll-include-cache"
gem "jekyll-feed"
gem "jekyll-sitemap"
gem "jekyll-archives"
GEMS

echo "----------------------------------------"
echo " INSTALLING GEMS"
echo "----------------------------------------"

cd "$SITE_DIR"
bundle install

echo "----------------------------------------"
echo " LAUNCHING ISOLATED CHROME WINDOW"
echo "----------------------------------------"

# Check if a Chrome process is already running using the specific DEV_PROFILE_DIR
if pgrep -f "Google Chrome.*--user-data-dir=$DEV_PROFILE_DIR"; then
  # Isolated Chrome IS running. Just open the URL in the existing profile.
  # We use the same --user-data-dir argument to ensure the URL opens in the correct instance.
  open -a "Google Chrome" --args \
    --user-data-dir="$DEV_PROFILE_DIR" \
    http://localhost:4000 &
    
  echo "Development Chrome detected. Opening http://localhost:4000 in existing isolated window."
else
  # Isolated Chrome is NOT running. Launch a clean, isolated window using -n.
  # Create the persistent directory if it doesn't exist
  mkdir -p "$DEV_PROFILE_DIR"

  open -n -a "Google Chrome" --args \
    --new-window \
    --user-data-dir="$DEV_PROFILE_DIR" \
    --no-first-run \
    --no-default-browser-check \
    --disable-sync \
    --disable-features=Crashpad,ChromeWhatsNewUI \
    --disable-application-cache \
    --aggressive-cache-discard \
    --disk-cache-size=0 \
    --media-cache-size=0 \
    http://localhost:4000 &
    
  echo "Development Chrome not detected. Launched new, isolated window at http://localhost:4000"
fi


echo "----------------------------------------"
echo " STARTING JEKYLL SERVE (LIVE RELOAD)"
echo "----------------------------------------"

bundle exec jekyll serve \
  --livereload \
  --force_polling \
  --future \
  --destination "$BUILD_DIR"