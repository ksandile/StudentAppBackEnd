<cfset rawJson = toString(getHttpRequestData().content)>
<cfset input = deserializeJSON(rawJson)>

<cfset sFunction = input["sFunction"]>
<cfset sName = input["sName"]>
<cfset sEmail = input["sEmail"]>
<cfset sPassword = input["sPassword"]>

<cfset studentHandler = createObject("component", "../handlers/student")>
<cfset result = studentHandler[sFunction](sName, sEmail, sPassword)>

<cfheader name="Access-Control-Allow-Origin" value="*">
<cfheader name="Content-Type" value="application/json">
<cfoutput>#serializeJSON(result)#</cfoutput>
