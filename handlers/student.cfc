<cfcomponent>

  <!-- Register Student -->
  <cffunction name="registerStudent" access="remote" returntype="any">
    <cfargument name="sFirstName" type="string" required="true">
    <cfargument name="sLastName" type="string" required="true">
    <cfargument name="sEmail" type="string" required="true">
    <cfargument name="sPassword" type="string" required="true">

    <cfinclude template="../db/dbConfig.cfm">

    <cfquery name="checkUser" datasource="#application.dsn#">
      SELECT sEmail FROM tStudent WHERE sEmail = <cfqueryparam value="#arguments.sEmail#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif checkUser.recordCount EQ 0>
      <cfquery datasource="#application.dsn#">
        INSERT INTO tStudent (sFirstName, sLastName, sEmail, sPassword)
        VALUES (
          <cfqueryparam value="#arguments.sFirstName#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.sLastName#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.sEmail#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.sPassword#" cfsqltype="cf_sql_varchar">
        )
      </cfquery>
      <cfreturn { status="success", message="Registration successful." }>
    <cfelse>
      <cfreturn { status="error", message="Email already registered." }>
    </cfif>
  </cffunction>

  <!-- Login Student -->
  <cffunction name="loginStudent" access="remote" returntype="any">
    <cfargument name="sEmail" type="string" required="true">
    <cfargument name="sPassword" type="string" required="true">

    <cfinclude template="../db/dbConfig.cfm">

    <cfquery name="loginQ" datasource="#application.dsn#">
      SELECT * FROM tStudent 
      WHERE sEmail = <cfqueryparam value="#arguments.sEmail#" cfsqltype="cf_sql_varchar">
        AND sPassword = <cfqueryparam value="#arguments.sPassword#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif loginQ.recordCount EQ 1>
      <cfset session.student = {
        id = loginQ.sStudentID,
        name = loginQ.sFirstName & " " & loginQ.sLastName,
        email = loginQ.sEmail
      }>
      <cfreturn { status="success", message="Login successful", student=session.student }>
    <cfelse>
      <cfreturn { status="error", message="Invalid credentials" }>
    </cfif>
  </cffunction>

</cfcomponent>
