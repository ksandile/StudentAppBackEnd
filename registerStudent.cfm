<cfheader name="Access-Control-Allow-Origin" value="*" />
<cfcontent type="application/json" />

<cftry>

    <!--- Get data from frontend --->
    <cfset requestBody = fileRead("php://input")>
    <cfset jsonData = deserializeJSON(requestBody)>

    <cfset firstName = trim(jsonData.sFirstName)>
    <cfset lastName = trim(jsonData.sLastName)>
    <cfset email = trim(jsonData.sEmail)>
    <cfset password = trim(jsonData.sPassword)>
    <cfset createdAt = now()>

    <!--- Insert into SQL Table --->
    <cfquery datasource="MyMax">
        INSERT INTO tStudent (sFirstName, sLastName, sEmail, sPassword, dCreatedAt)
        VALUES (
            <cfqueryparam value="#firstName#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#lastName#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#password#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#createdAt#" cfsqltype="cf_sql_timestamp">
        )
    </cfquery>

    <cfset response = {
        success = true,
        message = "Student registered successfully."
    }>

    <cfoutput>#serializeJSON(response)#</cfoutput>

    <cfcatch>
        <cfset errorResponse = {
            success = false,
            error = cfcatch.message
        }>
        <cfoutput>#serializeJSON(errorResponse)#</cfoutput>
    </cfcatch>

</cftry>
