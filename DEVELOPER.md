# Hinweise und Notizen

## Tiny File Manager
```
cd /srv/www
sudo git clone https://github.com/prasathmani/tinyfilemanager.git
sudo git checkout offline
sudo echo '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"\>\<html xmlns="http://www.w3.org/1999/xhtml"><head><title></title><meta http-equiv="refresh" content="0;url=http://127.0.0.1:8088/tinyfilemanager/tinyfilemanager.php" /></head><body></body></html>' > /srv/www/tinyfilemanger/index.html
sudo echo "<?php $auth_users = array('demo' => '$2y$10$9IY322ew1LrIwn1sFWXF0.lwYLX9D25NO8m7/YENgeXKIkiCdFE5y'); $default_timezone = 'Europe/Zurich'; $directories_users = array('demo' => '/home/demo/public_html'); ?>" > /srv/www/tinyfilemanger/config.php
mkdir /home/demo/public_html
sudo chmod 777 /home/demo/public_html
```

## Update

```bash
curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup-server.sh | bash -s server/x86_64-headless-nvidia-52-61.nix
```

```bash
curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/update_or_clone_teaching_git_repos.raku | raku -
```

## Manuelle Anpassungen

Wenn die Auflösung deines Displays nicht stimmt, bestimme die native Auflösungen deines Monitors unter Windows bzw. MacOS und übertrage diese in die VM unter Einstellungen -> Anzeige.

## benötigte Screen-Resolution wird nicht angezeigt

[Quelle](https://unix.stackexchange.com/questions/227876/how-to-set-custom-resolution-using-xrandr-when-the-resolution-is-not-available-i)

```bash
xrandr --size 1440x900
```


```bash
xrandr --listmonitors
```

```bash
xrandr -q
```

```bash
xrandr --verbose
```

### calculate new modeline string for xrandr

```bash
nix-shell -p libxcvt
```

```bash
# First we need to get the modeline string for xrandr
cvt 1920 1080

# In this case, the horizontal resolution is 1920px the
# vertical resolution is 1080px & refresh-rate is 60Hz.
# IMPORTANT: BE SURE THE MONITOR SUPPORTS THE RESOLUTION

# Typically, it outputs a line starting with "Modeline"
# e.g. "1920x1080_60.00"  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync
# Copy this entire string (except for the starting "Modeline")

# Now, use "xrandr" to make the system recognize a new
# display mode. Pass the copied string as the parameter
# to the --newmode option:
xrandr --newmode "1920x1080_60.00"  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync

# Well, the string within the quotes is the nick/alias
# of the display mode - you can as well pass something
# as "MyAwesomeHDResolution". But, careful! :-|

# Then all you have to do is to add the new mode to the
# display you want to apply, like this:
xrandr --addmode Virtual-1 "1920x1080_60.00"

# Virtual-1 is the display name, it might differ for you.
# Run "xrandr" without any parameters to be sure.
# The last parameter is the mode-alias/name which
# you've set in the previous command (--newmode)

# It should add the new mode to the display & apply it.
# Usually unlikely, but if it doesn't apply automatically
# then force it with this command:
xrandr --output Virtual-1 --mode "1920x1080_60.00"
```

### Permanently saving

maybe

```bash
echo "xrandr --size 1440x900
" >> ~/.xprofile 
```

or using string created above

```bash
xrandr --output Virtual-1 --mode "1920x1080_60.00"
```


## VirtualBox / UTM
Nach der initialen Installation einen Snapshot bzw. einen Clone erstellen - sicher ist sicher.

### Tastatur
Wenn VirtualBox unter Mac, ändere Tastatur-Layout zu

- Belegung (German, Switzerland) -> Variante (German, Switzerland, Macintosh)

### XFCE Einstellungen

- Bildschirmschoner ausschalten
- Energiesparoptionen auschalten
- Sperrbildschirm auschalten
- Benachichtigungen -> Anwendungen stumm schalten

### XFCE Shortcutes
Einstellungen -> Fensterverwaltung -> Tastatur

- Fenster Links/Rechts/Oben/Unten kacheln: CTRL+Super+Pfeiltasten

### XFCE DPI & Zoom
- Einstellungen -> Erscheinungsbild -> Einstellungen -> Fensterskalierung -> 2x
- Einstellungen -> Erscheinungsbild -> Schriften -> DPI -> Eigener Wert 96

### X-Server

DPI manuell setzen

```bash
echo 'Xft.antialias: 1' >> $HOME/.Xresources
echo 'Xft.dpi: 192' >> $HOME/.Xresources
echo 'Xft.hinting: 1' >> $HOME/.Xresources
```

Old Java-Applikationen Scaling issues

```bash
#!/bin/sh
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export XCURSOR_SIZE=32
export QT_AUTO_SCREEN_SCALE_FACTOR=1
start_java_application
```

Bildschirmanzeige
```bash
echo '#xrandr --output eDP-1 --mode 1920x1080 --dpi 120' >> $HOME/.xprofile
echo 'xrandr --output HDMI-1 --mode 1920x1080 --dpi 120' >> $HOME/.xprofile
```

## TigerJython
TigerJython einmal öffnen und eine Datei im Homedir abspeichern, damit das zukünfitg der Default-Pfad ist. Ansonsten starten die SuS in `/nix/store/path-to-tigerjython`, was unnnötig verwirrend ist.

### Beispiele in HomeDir kopieren
Wo sind diese?
```bash
ll /run/current-system/sw/bin/tigerjython
```
Copy
```bash
cp -r /nix/store/path-to-tigerjython/share/java/TestSamples $HOME/Dokumente/TigerJythonExamples
```

## Git

Submodule aktualisieren
```
git submodule update --recursive --remote
```

## Jupyter
Titel und Author zu Notebook "LaTeX-tauglich" hinzufügen:

https://nbconvert.readthedocs.io/en/latest/usage.html#latex

### Jupyter-Book
Wenn es etwas schöner sein soll: [jupyter-book](https://jupyterbook.org)

### Thonny

Die Fonts sind zu klein?

```bash
nano .config/Thonny/configuration.ini
```

Add:

<pre>
[general]
...
scaling = 2.0
...
</pre>

### Dock und Leiste

#### Leiste 1
- Screenshot
- Clipmenu
- Systemlast

#### Leiste 2
-Catfish
- Thonny
- TigerJython
- Filius
- Jupyter Lab
  - accessories-text-editor
  - nix-shell nix-shells/jupyter-lab.nix --run "jupyter-lab --notebook-dir=$HOME/Dokumente"
  - Arbeitsverzeichnis /home/demo/BYOD
- Unterlagen aktualisieren
  - raku $HOME/BYOD/update_or_clone_teaching_git_repos.sh
  - bash $HOME/BYOD/fetch_BYOD.sh

```bash
export EDU_PUBLIC_JUPYTER_NOTEBOOKS=github_pat_some-key
raku BYOD/update_or_clone_teaching_git_repos.raku
```

## Rechte CTRL-Taste fehlt - Vollbildmodus in VirtualBox
VirtualBox -> Einstellungen -> Allgemein -> Virtuelle Maschine

und dann bspw. die rechte Shift-Taste als "Host-Taste" definieren.
