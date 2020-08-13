# SolarEdge-Adapter01-Fibaro-HC3
SolarEdge-Wechselrichter - QuickApp für Fibaro HC3

|seAdapter1 für Fibaro HC3               |für das SolarEdge-Portal    |
|:-------------------------------------:|:------------------------------------:|
|![seA1-Logo](/images/seA1-Logo2.png)   |![SolarEdgeLogo](/images/seA1-SolarEdge-Logo2.png)             |

## Kurzbeschreibung
Die QuickApp **seAdapter1** liest ausgewählte Betriebsdaten eines SolarEdge-Wechselrichters über die API-Schnittstelle des SolarEdge-Portals zyklisch aus und stellt diese Daten als Übersicht in der QuickApp sowie im Bereich der globalen Variablen des Fibaro HC3 zur Verfügung.

## Settings/Parameter
Für den ordnungsgemäßen Betrieb der QuickApp sind Voreinstellungen (Parameter) erforderlich, die folgenden Standardwerte sind bereits eingespeichert. Bei Bedarf können mehrere der Parameter verändert werden.

1. **site-id:** - ID-Kennung des SolarEdge-Wechselrichters im SolarEdge-Portal in der Form 999999.
2. **api-key:** - Zugangskennung für die Abfrage der API-Schnittstelle des SolarEdge-Wechselrichters im SolarEdge-Portal.
3. **wait:** - Schalter, mit dessen Hilfe die QuickApp in den Leerlauf versetzt werden kann (wait= **yes/no**)
4. **globalvalues:** - Schalter, mit dessen Hilfe das Speichern von Livedaten im Bereich der globalen Variablen der´s HC3 aktiviert werden kann (**globalValues**=  **no/yes**)
5. **interval:** - Zeiteinstellung für den Abfragezyklus der API-Daten (interval= **60** steht für 60 Sekunden = 1 Minute)

![viewlokaleParameter](/images/seA1-lokaleParameter2.png "lokale Parameter")

Hinweis: der Parameter **interval** wird im unteren Wertebereich auf mindestens 60 Sekunden begrenzt, größere Werte können eingestellt werden.

## Globale Variablen
Die QuickApp kann ermittelte Livedaten des Wechselrichters im Bereich der globalen Variablen des HC3 abspeichern. Damit wird die zusätzliche Möglichkeit geschaffen, diese Meßwerte auch für Automatisierungen in Szenen zu verwenden.

1. **seTimeStamp:** - Zeitstempel für die letzte Messung. Der Zeitstempel zeigt das Datum in der Form <yyyy-mm-dd> und die Uhrzeit in der Form <hh:mm:ss> an.  

2. **sePowerCurrent:** - Aktuelle Erzeugung der PV-Anlage zum Zeitpunkt der Datenabfrage in kWh (Meßwert des Wechselrichters).

3. **seEnergyDay:** - Tageswert der Erzeugung der Photovoltaikanlage in kWh zum Zeitpunkt der Datenabfrage.

4. **seEnergyMonth:** - Monatswert der Erzeugung der Photovoltaikanlage in kWh zum Zeitpunkt der Datenabfrage.

5. **seEnergyYear:** - Jahreswert der Erzeugung der Photovoltaikanlage in kWh zum Zeitpunkt der Datenabfrage.

6. **seEnergyLifetime:** - Gesamtwert der Erzeugung der Photovoltaikanlage seit der Inbetriebnahme in kWh zum Zeitpunkt der Datenabfrage.

7. **seMoneyLifetime:** - Finanzielles Gesamtergebnis der Photovoltaikanlage seit der Inbetriebnahme in Euro zum Zeitpunkt der Datenabfrage. Dieser Wert wird im SolarEdge-Portal aus der eingegebenen Vergütung für Strom/kWh und dem Gesamtwert der Energieerzeugung berechnet.

## Voraussetzungen
Für die Nutzung des seAdapters1 ist ein SmartHome-System von Fibaro HC3 erforderlich. QuickApps sind Erweiterungen des Funktionsumfangs des Hubs, diese werden dort als "Geräte" verwaltet, die QuickApp muß somit als 'neues Gerät' im HC3 installiert werden.

## Ansichten
**Datenübersicht**

Die untere Datenübersicht der oben genannten Livedaten wird in der QuickApp zur Verfügung gestellt. Die Daten werden zyklisch gemäß dem aktivierten Zeitintervall aktualisiert.

![dataview](/images/seA1-Datenübersicht2.png "Datenübersicht")

**Ansicht der globalen Variablen**

Die QuickApp speichert im zentralen Bereich des HC3 für Variablen jeweils die aktuell ermittelten Leistungswerte des Wechselrichters ab. Voraussetzung dafür ist es, das diese Variablen vom Benutzer dort vorher hinzugefügt wurden und der interne Parameter "globaleValues" in der QuickApp auf "yes" gesetzt worden ist. Es ist zu beachten, dass die hinzugefügten Variablennamen in der gleichen Schreibweise eingegeben werden, wie sie weiter oben vorgegeben wurden!

![viewGlobaleVariablen](/images/seA1-GlobaleVariablen2.png "Globale Variablen")


## Automatisierungen mit Hilfe von Szenen

Mit SmartHome-Systemen können Automatisierungen im Haus, in Wohnungen oder auch in anderen Locations aufgebaut werden. Das System Fibaro HC3 steht für ein System, mit dem man sehr umfangreiche Automatisierungen realisieren kann. Automatisierungen können dort mit s.g. **Szenen** erstellt werden. Ein versierter Nutzer entwickelt in der Regel mehrere bis über 100 Szenen, mit denen er in seinem Heim automatische Abläufe realisiert.

**Szenen** sind nach dem Muster **If** - **Then** (- **Else**) strukturiert und können so verstanden werden: **Wenn** ein Zustand eines Gerätes, einer Variablen oder ein Ereignis eintritt, bspw. *die Haustür wurde geöffnet*, **dann** werden die folgenden Aktionen ausgelöst, bspw. *die Flurlampen angeschaltet*.

Für den Aufbau von Szenen stehen im Fibaro HC3 zwei Editoren zur Verfügung. Ein grafischer Blockeditor, mit dem auch nicht programmieraffine Nutzer Automatisierungen aufbauen können, und ein LUA-Editor, mit dem ein Nutzer mit Neigung zur Programmierung, Kenntnissen der Programmiersprache **LUA** und mit speziellen Systemfunktionen des Fibaro-Systems, dann auch sehr komplexe Steuerungen von Geräten, Schaltern, Lampen, Sirenen o.ä. Equipment realisieren kann. 

Für alle Geräte, die im Fibaro-System noch nicht standardmäßig implementiert werden können, steht das Instrument **QuickApp** zur Verfügung. Mit QuickApps können somit zusätzliche Geräte in ein SmartHome-System eingebunden werden.

Hier setzt die QuickApp **seAdapter1** für den SolarEdge-Wechselrichter an. Diese QuickApp wird als zusätzliches Gerät in das System eingefügt und fragt nach der Inbetriebnahme ausgewählte Betriebsdaten des Wechselrichters über die API-Schnittstelle des Internet-Portals ab. 

Um nun die ermittelten Livedaten des Wechselrichters auch für Automatisierungen nutzen zu können, stellt der **seAdapter1** die ermittelten Daten als Variablenwerte für die Verwendung in Szenen zur Verfügung.

Damit kann man jetzt, bspw. beim Erreichen eines festgelegten Erzeugungswertes (bspw. sePowerCurrent) für die Produktion einer Photovoltaikanlage, einen zusätzlichen Verbraucher zuschalten, oder eine Nachricht an ein Handy oder eine Mitteilung an einen Mail-Account versenden lassen, um diesen Sachverhalt mitzuteilen. Mit den aktuellen Smarthome-Systeme kann man nach dem Erhalt der Mitteilung dann bspw. auch manuelle über den Fernzugriff einen oder mehrere zusätzliche verbraucher anschalten.

Das folgende Bild zeigt ein Beispiel für eine grafische Blockszene, die gestartet (getriggert) wird, wenn die PV-Anlage abgeregelt wurde, bspw. bei dem Erreichen der 70% Grenze für die maximale Einspeisemenge in das öffentliche Stromnetz. Dafür werden die Leistungsdaten für die Produktion (siehe sbAdapter1) und die aktuellen Erzeugungsdaten des SolarEdge-Wechselrichters benutzt (Bedingung **If**). Sobald alle Bedingungen erfüllt sind (**Trigger-On + UND**), wird ein Verbraucher, hier ist es ein WallPlug (**Then**), angeschaltet. Gleichzeitig wird an den Anlagenbetreiber eine Mitteilung versendet, mit deren Hilfe der Anlagenbetreiber die Information erhält, dass die PV-Anlage gerade abgeregelt worden ist. Welche weiteren Geräte noch hinzu geschaltet werden, kann der Nutzer mit Blockszenen frei festlegen.

![SampleSzene](/images/seA1-SampleSzene2.png "Beispiel für eine Szene")

## API-Schnittstelle des Wechselrichters bzw. des SolarEdge-Portals

Die QuickApp seAdapter1 nutzt die folgende Abfragesyntax zur zyklischen Erfassung der Livedaten des Wechselrichters:

````https://monitoringapi.solaredge.com/site/<site-id>/overview.json?api_key=<api-key>)````

Diese Daten werden zur Anzeige gebracht und in den globalen Variablen als Momentanwerte gespeichert; eine Langzeitspeicherung der Daten, bspw. in einer Datenbank, erfolgt nicht.

Die folgenden API-Daten des Wechselrichters werden verarbeitet:

##### JSON

````
{
"overview": {
  "lastUpdateTime":"2020-08-13 15:22:58",
  "lifeTimeData":{
          "energy":2.8810484E7, 
          "revenue":3541.987
   },
  "lastYearData": {
          "energy":5841805.0
   },
  "lastMonthData": {
          "energy":445340.0
   },
  "lastDayData": {
          "energy":24402.0
   },
  "currentPower": {
          "power":2377.9
   },
   ...
  }
}
````
