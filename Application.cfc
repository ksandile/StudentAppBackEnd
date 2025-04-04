<!--- db/dbConfig.cfm --->
<cfif NOT structKeyExists(application, "dsn")>
    <cfset application.dsn = "P6DSN"> <!-- Your actual DSN name from ColdFusion Admin -->
</cfif>