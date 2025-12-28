# Dad Linux Demo Kit (Zorin OS)

A clean, demo-only setup that shows what Linux can look like after a little curiosity.
Designed for a second user account so you don’t clutter your dad’s environment.

## Quick start

1. Create a new user account on the laptop (Settings → Users) and log into it.
2. Open Terminal.
3. Run:

```bash
sudo apt update
sudo apt install -y git
git clone https://github.com/UncertainMeow/dad-linux-demo.git
cd dad-linux-demo
bash scripts/bootstrap.sh
```

When it finishes, it prints a fastfetch “reveal”.

## What this does

- Installs a curated set of useful tools and a few fun ones
- Pulls your dotfiles repo (optional and non-destructive by default)
- Applies a clean icon theme
- Sets up fastfetch config
- Gives you a repeatable, show-and-tell runbook

## Files

- `scripts/bootstrap.sh` demo installer + reveal
- `scripts/demo-screenshot.sh` optional helper for a “unixporn” screenshot setup
- `docs/demo-runbook.md` how to run the demo and what to say
- `docs/vm-demo.md` simple virtualization demo (Windows VM) and the “escape hatch” story

## Notes

This is meant to be impressive, not fragile.
If something fails, rerun the script. It’s safe.
