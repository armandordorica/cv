#!/bin/zsh
# publish.sh — compile CV, sync PDF to website, push both repos

set -e

CV_DIR="$HOME/Documents/cv"
SITE_DIR="$HOME/cv-armando"

echo "▶ Compiling LaTeX..."
cd "$CV_DIR"
xelatex -interaction=nonstopmode main.tex | tail -2

echo "▶ Copying PDF to website..."
cp "$CV_DIR/main.pdf" "$SITE_DIR/public/cv.pdf"

echo "▶ Pushing CV repo..."
cd "$CV_DIR"
git add main.tex main.pdf
git diff --cached --quiet && echo "  (no CV changes)" || git commit -m "Update CV" && git push origin main

echo "▶ Pushing website repo..."
cd "$SITE_DIR"
git add public/cv.pdf
git diff --cached --quiet && echo "  (no PDF changes)" || git commit -m "Sync CV PDF" && git push origin main

echo "✓ Done — cv.armandoordorica.com/cv.pdf is up to date"
