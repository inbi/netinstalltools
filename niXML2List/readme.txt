
niXML2List (c)2005-2006 by flatbyte.com
==========================

Die beiden Skripte erstellen jeweils eine Textdatei.

BuildNiServerListFromXML.js erstellt "NiServerList.txt"
BuildNiSharesFromXML.js erstellt "NiServerShares.txt"

Zuvor muss die NetInstallkonfiguration per rechts-Klick in ein
XML exportiert werden. Der Pfad zu dieser Datei muss in beiden
Skipts in der Variable "sDefaultXMLFilename" zu Beginn des Skripts
definiert/geaendert werden.

Im Beispiel ist der Pfad/Dateiname auf "e:\\netinst\\xml\\export.xml"
eingestellt (bitte die doppelten Backslash (\) beachten.

Nach Erstellung der Textdateien können Bachdateien oder Skripte
darauf zugreifen. 

Demobatches im Zip
=============

"PingAllServers.cmd": Pingt alle NetInstallserver aus der Liste an.
"DeleteNiServerShareTmpFiles.cmd": Löscht alle temporaeren Dateien
von NetInstall (ni*.tmp) in den jeweiligen Shares.

Disclaimer
=======
Diese Software unterliegt der Artistic License.
(http://www.opensource.org/licenses/artistic-license.php)