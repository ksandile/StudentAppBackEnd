<cfheader name="Access-Control-Allow-Origin" value="*" />
<cfheader name="Access-Control-Allow-Methods" value="POST, GET, OPTIONS" />
<cfheader name="Access-Control-Allow-Headers" value="Content-Type" />
<cfcontent type="application/json" />

<cftry>
    <!--- Get data from the frontend (request body) --->
    <cfset requestBody = getHttpRequestData().content> <!--- Corrected method to read request body --->
    <cfset formData = deserializeJSON(requestBody)> <!--- Deserialize JSON body --->

    <!--- Extract email and password from the incoming request --->
    <cfset email = trim(formData.sEmail)>
    <cfset password = trim(formData.sPassword)>

    <!--- Query the database to find a student by email --->
    <cfquery name="getStudent" datasource="MyMax">
        SELECT sFirstName, sLastName, sEmail, sPassword
        FROM tStudent
        WHERE sEmail = <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <!--- Check if the student exists --->
    <cfif getStudent.recordCount EQ 0>
        <cfset response = {
            status = "error",
            message = "Email not found."
        }>
    <cfelseif NOT passwordEQ(getStudent.sPassword, password)>
        <cfset response = {
            status = "error",
            message = "Invalid password."
        }>
    <cfelse>
        <!--- If the password matches, return success response --->
        <cfset response = {
            status = "success",
            message = "Login successful",
            data = {
                firstName = getStudent.sFirstName,
                lastName = getStudent.sLastName,
                email = getStudent.sEmail
            }
        }>
    </cfif>

    <!--- Output the response as JSON --->
    <cfoutput>#serializeJSON(response)#</cfoutput>

<cfcatch>
    <!--- Handle any errors and output error message ---> 
    <cfset response = {
        status = "error",
        message = "An error occurred while processing your request."
    }>
    <cfoutput>#serializeJSON(response)#</cfoutput>
</cfcatch>
</cftry>
