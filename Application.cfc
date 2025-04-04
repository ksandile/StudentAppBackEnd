<!--- db/dbConfig.cfm --->
<cfif NOT structKeyExists(application, "dsn")>
    <cfset application.dsn = "My Max"> <!-- Your actual DSN name from ColdFusion Admin -->
</cfif>