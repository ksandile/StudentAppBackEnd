<cfif CGI.REQUEST_METHOD eq "OPTIONS">
    <cfheader name="Access-Control-Allow-Origin" value="http://localhost:4200">
    <cfheader name="Access-Control-Allow-Methods" value="POST, GET, OPTIONS, PUT, DELETE">
    <cfheader name="Access-Control-Allow-Headers" value="Content-Type, Authorization">
    <cfheader name="Access-Control-Max-Age" value="3600">
    <cfabort>
</cfif>

<cfheader name="Access-Control-Allow-Origin" value="http://localhost:4200">
<cfheader name="Content-Type" value="application/json">

<cftry>
    <cfset requestBody = toString(getHttpRequestData().content)>
    <cfset jsonData = deserializeJSON(requestBody)>
    
    <cfset fullName = trim(jsonData.sName)>
    <cfset email = trim(jsonData.sEmail)>
    <cfset password = trim(jsonData.sPassword)>

    <cfset nameParts = listToArray(fullName, " ")>
    <cfset firstName = arrayLen(nameParts) GTE 1 ? nameParts[1] : "">
    <cfset lastName = arrayLen(nameParts) GTE 2 ? nameParts[2] : "">

    <!--- Call CFC --->
    <cfinvoke component="student" method="registerStudent" returnvariable="result">
        <cfinvokeargument name="sFirstName" value="#firstName#">
        <cfinvokeargument name="sLastName" value="#lastName#">
        <cfinvokeargument name="sEmail" value="#email#">
        <cfinvokeargument name="sPassword" value="#password#">
    </cfinvoke>

    <cfif result EQ "success">
        <cfoutput>#serializeJSON({ status="success", message="Student registered successfully." })#</cfoutput>
    <cfelse>
        <cfoutput>#serializeJSON({ status="error", message="#result#" })#</cfoutput>
    </cfif>

<cfcatch>
    <cfoutput>#serializeJSON({ status="success", message="Student registered successfully." })#</cfoutput>
</cfcatch>
</cftry>
