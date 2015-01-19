<?xml version="1.0"?>
<LoginInformation>
<%@language=jscript%>
<%
// webservice interface zur bereitstellung von berechtigungen fuer netinstall
// version: 1.0
// autor: ingo bieneck (www.flatbyte.com)
// last change: 09/2004

// variables (set to approriate values)
sNiwsServer="myserver";
sNiwsDatabase="NiWebService";
sNiwsUser="niws";
sNiwsPassword="niws";

// build connection string
sConnectionString = "Provider=SQLOLEDB;User ID="+sNiwsUser+";Data Source="+sNiwsServer+";Initial Catalogue="+sNiwsDatabase+";pwd="+sNiwsPassword+";"

// get provided parameter
sProvidedMachineName=""+Request.QueryString("pcname");
sMode=""+Request.QueryString("mode");
//strWDNodeString=""+Request.QueryString("NetObject")+"";
//strWDNetObjectsString=""+Request.QueryString("NetObjects")+"";

//build sql string
var sSqlString = "select * from NiWS_MachineProjectsView";
if(sMode=="client") {
   sSqlString+=" where sMachineName = '"+sProvidedMachineName+"'";
   }
else if(sMode="mgr") {
   
   }

// database connectivity
try {
   var oConnection= new ActiveXObject("ADODB.Connection");
   var oRecordset= new ActiveXObject("ADODB.Recordset");
   oConnection.Open(sConnectionString);
   }
catch(e) {
   Response.Write(e.description+"<br>");
   }

if(oConnection) {
   try { 	
      //Response.Write(sSqlString+"<br>");

      oRecordset.Open(sSqlString, oConnection);
      while (!oRecordset.EOF) {
         // iterate and output
         Response.Write("<group>\n");
         Response.Write(oRecordset("sProject")+"\n");
         Response.Write("</group>\n");
   	   oRecordset.MoveNext();
         }
   	oRecordset.Close();
      }
   catch(e) {
      Response.Write(e.description+"<br>");
      }
   }
%>
</LoginInformation>
