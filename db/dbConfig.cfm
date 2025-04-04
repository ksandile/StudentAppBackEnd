<cfcomponent displayname="StudentDB">

    <!--- Insert student --->
    <cffunction name="addStudent" access="remote" returntype="string">
        <cfargument name="sFirstName" type="string" required="true">
        <cfargument name="sLastName" type="string" required="true">
        <cfargument name="sEmail" type="string" required="true">
        <cfargument name="sPassword" type="string" required="true">

        <cfquery datasource="MyMax">
            INSERT INTO tStudent (sFirstName, sLastName, sEmail, sPassword)
            VALUES (
                <cfqueryparam value="#arguments.sFirstName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.sLastName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.sEmail#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.sPassword#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>

        <cfreturn "Student added successfully">
    </cffunction>

    <!--- Get all students --->
    <cffunction name="getStudents" access="remote" returntype="query">
        <cfquery name="students" datasource="MyMax">
            SELECT * FROM tStudent ORDER BY dCreatedAt DESC
        </cfquery>

        <cfreturn students>
    </cffunction>

</cfcomponent>
