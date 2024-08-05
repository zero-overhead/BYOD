# BYOD-Windows-Rechner + NixOS@WSL
BYOD $\to$ heterogene Umgebung + WSL + NixOS $\to$ indentische Umgebung fürs Programmieren im Klassenraum.

## Setup

1. Starte eine Kommandozeile (CommandPrompt)

2. Aktiviere WSL
```bash
wsl --install --no-distribution
```

3. Lade die Datei NixOS-WSL-Launcher.zip von https://github.com/nix-community/NixOS-WSL und entpacke diese, bspw. im Ordner Downloads. Führe dann ff. Befehle aus
```bash
cd Downloads\NixOS-WSL-Launcher
.\NixOS.exe install
wsl -s NixOS
```
4. Starte die NixOS.app

5. Hole dir die aktuelle Konfiguration
```bash
nix-shell -p git
git clone --single-branch --branch wsl https://github.com/zero-overhead/BYOD
```

6. Kopiere die Konfiguration an die richtige Stelle
```bash
cp -r BYOD/con* /etc/nixos/
```

7. Lade die Konfiguration
```bash
sudo nix-channel --update
sudo nixos-rebuild switch
```

8. Test
- jupyter: ```jupyter lab```
- thonny: ```thonny```
- ollama: ```ollama list```
- oterm: ```oterm```
- open-webui: ```http://127.0.0.1:8080/```

9. Workaround
- TigerJython: ```export NIXPKGS_ALLOW_UNFREE=1; nix run github:nixos/nixpkgs/pull/316431/head#tigerjython --extra-experimental-features "nix-command flakes" --impure```
- Filius: ```nix run github:nixos/nixpkgs/pull/326102/head#filius --extra-experimental-features "nix-command flakes"```
