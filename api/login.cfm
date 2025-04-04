<cfparam name="sEmail" default="">
<cfparam name="sPassword" default="">

<cfset studentHandler = createObject("component", "../handlers/student")>
<cfset result = studentHandler.loginStudent(sEmail, sPassword)>

<cfheader name="Content-Type" value="application/json">
<cfoutput>#serializeJSON(result)#</cfoutput>
