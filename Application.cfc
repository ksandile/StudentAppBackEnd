<!--- db/dbConfig.cfm --->
<cfif NOT structKeyExists(application, "dsn")>
    <cfset application.dsn = "P6DSN">
</cfif>