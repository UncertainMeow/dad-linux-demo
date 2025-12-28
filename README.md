# Dad Linux Demo

This repo is a reversible Linux demo setup for Zorin OS.
It is meant to be run on a separate demo user account.

## Quick start

1. Go to the repo root.
2. Reset the user desktop to a clean first-login feel.

bash scripts/reset-desktop.sh

You will be logged out.

3. Log back in.
4. Run the demo bootstrap.

bash scripts/bootstrap.sh

This installs apps, applies visible settings, pulls dotfiles, and runs neofetch.

## Visible settings demo

Run this anytime.

bash scripts/apply-settings.sh

It will prompt you to pick a wallpaper and will try to force dark mode.

## Settings as files demo

Backup.

bash scripts/backup-settings.sh

Restore.

bash scripts/restore-settings.sh

## Screenshot demo

bash scripts/demo-screenshot.sh

Arrange windows first, then take an interactive screenshot.
