# BYOD-Windows-Rechner + NixOS@WSL
BYOD $\to$ heterogene Umgebung + WSL + NixOS $\to$ indentische Umgebung fürs Programmieren im Klassenraum.

## Setup

1. Starte eine Kommandozeile (CommandPrompt)

2. Aktiviere WSL
```bash
wsl --install --no-distribution
```

3. Lade die Datei NixOS-WSL-Launcher.zip von https://github.com/nix-community/NixOS-WSL (the latest release -> Assets) und entpacke diese, bspw. im Ordner Downloads. Führe dann ff. Befehle aus
```bash
cd Downloads\NixOS-WSL-Launcher
.\NixOS.exe install
wsl -s NixOS
```

4. Schliesse nun die Kommandozeile.

5. Starte die NixOS.app

6. Hole dir die aktuelle Konfiguration
```bash
nix-shell -p git
git clone --single-branch --branch wsl https://github.com/zero-overhead/BYOD
```

7. Kopiere die Konfiguration an die richtige Stelle
```bash
sudo cp -r BYOD/con* /etc/nixos/
```

8. Lade die Konfiguration
```bash
sudo nix-channel --update
sudo nixos-rebuild switch
```

9. Test
- jupyter: ```jupyter lab``` (copy/paste der angezeigten URL - ähnlich dieser http://localhost:8888/lab?token=7e7d9be85131b5df3840d98690f93fe5145baf9231535b28 - in deinen Browser)
- TigerJython: ```tjython```
- thonny: ```thonny```
- ollama: ```ollama list``` (installiere zunächst mindestens ein Modell - siehe https://ollama.com/models - starte mit einem kleinen Modell, für das du nicht viel Rechenpower benötigst, wie etwa durch Eingabe von ```ollama run deepseek-coder:1.3b```)
- oterm: ```oterm```
- open-webui: ```http://127.0.0.1:8080/``` (copy/paste in deinen Browser)
- Filius: ```filius```
