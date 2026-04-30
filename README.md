# Waybar Configuration

Custom [Waybar](https://github.com/Alexays/Waybar) setup for [Hyprland](https://hyprland.org), featuring a floating top bar with rounded corners and grouped modules.

## Screenshot

![Waybar Screenshot](https://raw.githubusercontent.com/stulzer/waybar/main/screenshot.png)

## Layout

```
modules-left
[Launcher | Active Window]

modules-center
[CPU MEM | Media]  [Workspaces]  [Clock | Updates | Heroic]

modules-right
[Audio Monitor BT Network Battery | Power]
```

### Modules

| Module | Description |
|---|---|
| **Launcher** | Opens Walker (app launcher) on click, Kitty on right-click |
| **Active Window** | Shows focused window class and title via `window.sh` |
| **CPU / Memory** | Usage level icons, click opens btop |
| **Media** | Current track from playerctl |
| **Workspaces** | 8 persistent Hyprland workspaces |
| **Clock** | 12h time, date, and calendar tooltip |
| **Updates** | Available pacman updates via `scripts/check-updates.sh` |
| **Heroic** | Launches Heroic Games Launcher on click |
| **PulseAudio** | Volume icon, click opens pavucontrol |
| **Monitor Toggle** | Enables/disables laptop display (eDP-1) via `scripts/monitor-toggle.sh` |
| **Bluetooth** | Status icon, click opens Blueman |
| **Network** | Wi-Fi/Ethernet status, click opens nm-connection-editor |
| **Battery** | Charge level with warning/critical states |
| **Power** | Power menu via Walker |

## Scripts

- **`window.sh`** - Polls Hyprland for the active window and outputs Pango-markup JSON for the active window module.
- **`scripts/check-updates.sh`** - Runs `checkupdates` and outputs a JSON object with update count.
- **`scripts/monitor-toggle.sh`** - Toggles the laptop display (eDP-1) on/off by editing `hyprland.conf`.

## Dependencies

### Required

| Package | Purpose |
|---|---|
| [waybar](https://github.com/Alexays/Waybar) | Status bar |
| [hyprland](https://hyprland.org) | Wayland compositor (workspaces, active window) |
| [jq](https://jqlang.github.io/jq/) | JSON processing in `window.sh` |

### Fonts

| Package | Purpose |
|---|---|
| [Maple Mono NF](https://github.com/subframe7536/maple-font) | Bar font (includes Nerd Font icons) |

### Applications (launched on click)

| Package | Purpose |
|---|---|
| [walker](https://github.com/abenz1267/walker) | App launcher and power menu |
| [kitty](https://sw.kovidez.net/kitty/) | Terminal emulator |
| [btop](https://github.com/aristocratos/btop) | System monitor (CPU/Memory click) |
| [pavucontrol](https://freedesktop.org/software/pulseaudio/pavucontrol/) | PulseAudio GUI volume control |
| [pamixer](https://github.com/cdemoulins/pamixer) | CLI PulseAudio mixer (mute toggle) |
| [blueman](https://github.com/blueman-project/blueman) | Bluetooth manager |
| [nm-connection-editor](https://wiki.gnome.org/Projects/NetworkManager) | NetworkManager connection editor |
| [playerctl](https://github.com/altdesktop/playerctl) | MPRIS media player control |
| [pacman-contrib](https://gitlab.archlinux.org/pacman/pacman-contrib) | Provides `checkupdates` for the updates module |
| [heroic-games-launcher](https://heroicgameslauncher.com) | Game launcher (Epic, GOG, Amazon) |

### Arch Linux install

```bash
sudo pacman -S waybar hyprland jq kitty btop pavucontrol pamixer blueman \
  networkmanager playerctl pacman-contrib
```

Walker and Maple Mono NF are available from the AUR:

```bash
yay -S walker-bin maplemono-ttf
```

## File Structure

```
~/.config/waybar/
├── config.jsonc              # Module configuration
├── style.css                 # GTK CSS styling
├── window.sh                 # Active window tracker
└── scripts/
    ├── check-updates.sh      # Pacman update checker
    └── monitor-toggle.sh     # Laptop display toggle
```
