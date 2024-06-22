# BYOD + VirtualBox + NixOS + home-manager
BYOD $\to$ heterogene Umgebung + (VirtualBox + NixOS + home-manager) $\to$ indentische Umgebung fürs Programmieren im Klassenraum.

Für Windows-, Mac- oder Linux-Rechner aber ~~iPad~~.

## Vor dem Unterricht
1. Starte deinen Computer, dann VirtualBox und dann die NixOS-VM
2. Neue Unterrichtsmateralien zum ThemaXYZ holen:
```bash
cd ~/Documents
git clone https://github.com/zero-overhead/ThemaXYZ
```
3. Bestehende Unterrichtsmateralien zum ThemaXYZ aktualisieren:
```bash
cd ~/Documents/ThemaXYZ
git pull
```
Falls es dabei zu Fehlern kommt und du nicht mehr weiter weisst: Änderungen speichern, Backup anlegen (so geht nichts verloren) und main-Branch auf Ausgangszustand zurücksetzen:
```bash
git commit -am"Notfallsicherung1" # alle Änderungen speichern
git branch Notfallsicherung1 # neuen Branch als Sicherungskopie anlegen
git checkout main # auf main Branch wechseln
git fetch --all
git reset --hard origin/main
```
4. Je nach Bedarf TigerJython, Thonny, Jupyter, Filius, VS-Code etc. starten

## Zum Ende des Unterrichts
1. Alle bearbeiteten Dateien speichern
2. VM sichern und VirtualBox beenden

## Einmaliges Setup
1. BYOD - du hast einen Windows-, Mac- oder Linux-Rechner aber ~~iPad~~ ?
2. Installiere [VirtualBox](https://www.virtualbox.org/wiki/Downloads) auf deinem Rechner
3. Lade das [NixOS-VirtualBox](https://nixos.org/download/#nixos-virtualbox)-Image herunter
4. Starte VirtualBox und importiere das gerade heruntergeladene NixOS-VirtualBox-Image und
5. setze der Virtuellen Maschine (VM) den RAM auf 4GB und die Prozessoren auf 2 oder 3
6. Starte VM, du wirst automatisch eingelogged
7. Setze Tastatur-Layout und Zeitzone (Settings -> Keyboard und Settings -> Timezone)
8. Öffne eine Konsole (Kommandozeile, Terminal) und installiere [Home-Manager Stand Alone](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) durch ff. Befehle:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager

nix-channel --update
```

Ausloggen und wieder Einloggen. Dann

```bash
nix-shell '<home-manager>' -A install
```
9. Clone das Git-Repository mit der Systemkonfiguration für den Informatikunterricht
```bash
nix-shell -p git
```
dann
```bash
git clone https://github.com/zero-overhead/BYOD
mv ~/.config/home-manager ~/.config/home-manager-backup
mv BYOD ~/.config/home-manager
mkdir ~/.config/nix
cp ~/.config/home-manager/nix.conf ~/.config/nix/
```
10. Erstelle die Unterrichtsumgebung
```bash
home-manager switch
```
11. Ausloggen und wieder einloggen (User "demo" und Passwort "demo") und dann überprüfen, ob benötigte Software installiert ist.
    - TigerJython
    - Filius
    - Jupyter
    - Thonny
    - Visual Studio Code
12. Wenn alles i.O. ist, lege einen Sicherungspunkt für diese VM in VirtualBox an - so kannst du, wenn mal etwas schief gegangen ist, jederzeit auf diesen sauberen Zustand zurückwechseln.