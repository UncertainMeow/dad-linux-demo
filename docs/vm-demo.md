# Virtualization demo (the “escape hatch”)

The point of this demo is not “replace Windows”.
The point is “you have options”.

## Beginner path: GNOME Boxes

Boxes is a friendly app for running virtual machines.

Install:

```bash
sudo apt update
sudo apt install -y gnome-boxes
```

### Windows VM demo outline

1. Download a Windows ISO from Microsoft on the host
2. Open Boxes
3. Create a new VM and select the Windows ISO
4. Give it:
   - 2 CPU cores (or 4 if available)
   - 4 to 8 GB RAM
   - 64 GB disk
5. Install Windows like normal

### Make it feel “native”

Inside the Windows VM, install Boxes guest tools:
- Open Edge in the VM
- Visit win.gnomeboxes.org
- Install spice guest tools

This improves:
- copy/paste
- screen resizing
- mouse integration

## “More control” path: virt-manager

If Boxes feels limited:

```bash
sudo apt update
sudo apt install -y qemu-kvm virt-manager virtinst libvirt-daemon-system libvirt-clients
```

virt-manager is still normal-person-friendly, just more knobs.

## What to say

- “If you ever miss Windows, you can run it in a window.”
- “You don’t lose access to anything.”
- “Linux isn’t a cage. It’s a workshop.”

## About macOS VMs

macOS virtualization is generally permitted only on Apple hardware under Apple’s licensing terms.
If your goal is “learn macOS basics”, simplest options are:
- iCloud.com in the browser for Apple services
- borrowing a Mac, or buying a used Mac mini for a true macOS environment

You can still use Linux as your main system and treat macOS like a separate, optional tool.
