<cfparam name="sEmail" default="">
<cfparam name="sPassword" default="">

<cfset studentHandler = createObject("component", "../handlers/student")>
<cfset result = studentHandler.loginStudent(trim(sEmail), trim(sPassword))>

<cfheader name="Access-Control-Allow-Origin" value="*">
<cfheader name="Content-Type" value="application/json">
<cfoutput>#serializeJSON(result)#</cfoutput>
