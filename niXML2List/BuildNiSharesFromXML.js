// builds netinstall servershare-list from xml.

var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
var fso=new ActiveXObject("Scripting.FileSystemObject");
var wsh=new ActiveXObject("WScript.Shell");
var envTemp=wsh.ExpandEnvironmentStrings("%temp%");
var sDefaultXMLFilename="e:\\netinst\\xml\\export.xml";
var sSourcePath=WScript.ScriptFullName.replace(new RegExp(WScript.ScriptName), "");
var sOutputfileName=sSourcePath+"NiServerShares.txt"
var srvList=new Array();

var nodeList;
xmlDoc.async = false;
xmlDoc.resolveExternals = false;

try {
   xmlDoc.load(sDefaultXMLFilename);

   nodeList = xmlDoc.documentElement.getElementsByTagName("NCPObject");
   for (var i=0; i<nodeList.length; i++) {
      for (var j=0; j<nodeList.item(i).attributes.length; j++) {
         if(nodeList.item(i).attributes(j).text=="SERVER") {
            var sShare=nodeList.item(i).childNodes.item(1).childNodes.item(0).attributes(2).text;
            addUniqueArray(sShare.replace(/%currentserver%/i, nodeList.item(i).attributes(0).text))
            }
         }
     }
   }
catch(e) {
   WScript.Echo("XML Parsing Error: "+e.description);
   }

srvList.sort();

try { fso.DeleteFile(sOutputfileName, 1); }
catch(e) {;}

var hFile = fso.OpenTextFile(sOutputfileName, 2, 1, 0);
for(n=0;n<srvList.length;n++) {
   hFile.WriteLine(srvList[n]);
   }
hFile.Close();

wsh.Popup("Processed "+srvList.length+" server entries!", 2, WScript.ScriptName, 64);

function addUniqueArray(s) {
   var bAddItem=true;
   for(l=0;l<srvList.length;l++) {
      if(s==srvList[l]) bAddItem=false;
      }
	if(bAddItem) srvList.push(s);
   return;
   }


