# Dad Linux Demo Kit (Zorin OS)

This is a demo-only setup for a fresh user account on Zorin OS.

## Run it

```bash
sudo apt update
sudo apt install -y git
git clone <this repo>
cd dad-linux-demo
bash scripts/bootstrap.sh
```

During the run, you will get an interactive wallpaper picker.

## Files

- `scripts/bootstrap.sh` installs tools, applies visible settings, ends with a fastfetch reveal
- `scripts/apply-settings.sh` interactive wallpaper picker + dark mode + icons + text scaling
- `scripts/backup-settings.sh` exports dconf settings to `settings/dconf-backup.txt`
- `scripts/restore-settings.sh` replays that settings file on a new machine
- `scripts/demo-screenshot.sh` prompts you then opens interactive screenshot tool
- `assets/wallpapers/` contains the 3 wallpaper options
