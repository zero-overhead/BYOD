# Notizen zur Einrichtung

## Basis-VM

Wir benötigen eine Virtuelle Maschine (VM) mit dem Betriebssystem [NixOS](https://nixos.org/).

### Vorbereitung

### Windows/Mac mit Intel- oder AMD-CPU oder Windows mit ARM-CPU (Snapdragon)

- Installiere VirtualBox. Du findest den Download unter https://www.virtualbox.org/
- Importiere die VM-Datei ```NixOS_SuS.ova``` vom USB-Stick direkt in VirtualBox.
- Starte die VM
- Nutzer/Passwort: demo/demo
- Mit der rechten CTRL+F wechselst du ins Vollbild und wieder zurück. Alternativ ziehe die Maus an den unteren Bildschirmrand, dort siehst du einen Knopf ```_``` bzw. ```x``` zum verlassen der VM. Oder ziehe mit drei Fingern auf deinem Touchpad aufwärts oder abwärts.
- Unter `Anwendung -> Einstellungen -> Anzeige` kannst du - falls nötig - die Auflösung korrigieren.

### Mac mit Apple-CPU (M1/M2/M3/M4)

- Installiere UTM. Du findest den Download unter https://mac.getutm.app/
- Kopiere die Datei ```NixOS_SuS.utm.zip``` vom USB-Stick auf deinen Computer nach ```Downloads``` - bitte nicht nach OneDrive oder in einen anderen Cloud-Speicher!
- Entpacke die Datei ```NixOS_SuS.utm.zip``` durch Doppelklick. Das kann etwas dauern ...
- Verschiebe nun die ```NixOS_SuS.utm``` von ```Downloads``` in dein Heimatverzeichnis, i.d.R. ```/Users/DeinName```, bitte nicht nach OneDrive oder in einen anderen Cloud-Speicher!
- Starte UTM
- Öffne die Datei ```NixOS_SuS.utm``` aus deinem Heimatverzeichnis in UTM unter "Neue Virtuelle Maschine erstellen -> öffnen" und folge den Anweisungen.
- Passe die Auflösung deines Bildschirms an. Rechte Maustaste -> Edit -> Bildschirm
- Starte die VM
- Nutzer/Passwort: demo/demo


### Tastatur
Falls bei dir die Tastatur nicht korrekt eingestellt ist - teste das z.B. mit dem `@`-Zeichen oder `$` etc. - korrigiere dieses Problem unter 

- Einstellungen -> Tastatur -> Tastaturbelegung

### Bei mir funktioniert das nicht ...

Falls das Setup auf deinem Computer nicht gelingt:

- installiere die benötigten Anwendungen direkt auf deinem Computer
    - https://tigerjython.ch/de/products/download
    - https://thonny.org/
    - https://www.lernsoftware-filius.de/
    - https://jupyter.org/
    - ...

**oder**

- nutze fürs Programmieren einen (älteren) Laptop, den du bei Freunden oder Familie für das Schuljahr ausleihst. Aktuell werden viele (an sich tadellose) Laptops ausgemustert, da sie die Hardwareanforderungen für Windows 11 nicht erfüllen. 

**oder**

- verwende für die Programmierübungen einer der vielen die Online-Lösungen wie etwa
    - https://webtigerpython.ethz.ch/
    - https://cxedu.ethz.ch/
    - https://colab.research.google.com/
    - ...

**Aber**: Support durch deine Informatik-Lehrperson wird nur für das Standard-Programmier-Setup via VM geleistet.