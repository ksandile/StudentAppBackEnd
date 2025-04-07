<cfcomponent displayname="StudentService">

    <cffunction name="registerStudent" access="remote" returntype="string">
        <cfargument name="sFirstName" type="string" required="true">
        <cfargument name="sLastName" type="string" required="true">
        <cfargument name="sEmail" type="string" required="true">
        <cfargument name="sPassword" type="string" required="true">

        <cfset var result = "">
        <cftry>
            <cfquery datasource="YourDSN">
                INSERT INTO tStudent (sFirstName, sLastName, sEmail, sPassword)
                VALUES (
                    <cfqueryparam value="#sFirstName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#sLastName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#sEmail#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#sPassword#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>
            <cfset result = "success">
            <cfcatch>
                <cfset result = "error: #cfcatch.message#">
            </cfcatch>
        </cftry>

        <cfreturn result>
    </cffunction>

    <cffunction name="loginStudent" access="remote" returntype="any">
        <cfargument name="sEmail" type="string" required="true">
        <cfargument name="sPassword" type="string" required="true">

        <cfset var userData = "">
        <cfquery name="userData" datasource="YourDSN">
            SELECT sID, sFirstName, sLastName, sEmail, dCreatedAt
            FROM tStudent
            WHERE sEmail = <cfqueryparam value="#sEmail#" cfsqltype="cf_sql_varchar">
              AND sPassword = <cfqueryparam value="#sPassword#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif userData.recordCount EQ 1>
            <cfset session.user = userData>
            <cfreturn {status: "success", user: userData}>
        <cfelse>
            <cfreturn {status: "invalid", message: "Invalid credentials"}>
        </cfif>
    </cffunction>

</cfcomponent>
