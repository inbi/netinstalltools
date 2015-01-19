//var xmlDoc = new ActiveXObject("Msxml2.DOMDocument");
var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
var nodeList;
xmlDoc.async = false;
xmlDoc.resolveExternals = false;
xmlDoc.load("ni_sitetree.xml");

nodeList = xmlDoc.documentElement.getElementsByTagName("NCPObject");
for (var i=0; i<nodeList.length; i++) {
   //WScript.Echo(nodeList.item(i).baseName);
   for (var j=0; j<nodeList.item(i).attributes.length; j++) {
      //WScript.Echo("_"+nodeList.item(i).attributes(j).text);
      if(nodeList.item(i).attributes(j).text=="SERVER") WScript.Echo("***"+nodeList.item(i).attributes(0).text);
      }
  }

