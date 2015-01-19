
var xmlRoot = parseConfiguration("ni_sitetree.xml");
var aServers=new Array();
var k=0;

var NCPObjNodes = xmlRoot.selectNodes("NCPObject");
for (i = 0; i < NCPObjNodes.length; i++)  { // for every ncpobj
   //if(NCPObjNode.attributes.getNamedItem("type")=="SERVER") aServers[k++]=obj.text;
   WScript.Echo(i+""+NCPObjNodes.item(i).text);
   }


function parseConfiguration(strFileName)
{
	var gObjFs = new ActiveXObject("Scripting.FileSystemObject");
	// Parse the XML file that contains the URLs to check
	var xmlTree = new ActiveXObject("Microsoft.XMLDOM");
	xmlTree.async = false
	if (!gObjFs.FileExists(strFileName)) throw "File Name '"  + strFileName + "' does not exist";
	if (!xmlTree.load(strFileName)) throw "Failed to load file as XML.\n" + 
	                         xmlTree.parseError.url + ":" + xmlTree.parseError.line + "  " + xmlTree.parseError.reason;
	var xmlRoot = xmlTree.documentElement;
	
	return xmlRoot;
}


