<cfcomponent>
    <cfscript>
        this.name = "StudentBackEndApp";
        this.sessionManagement = true;
        this.applicationTimeout = createTimeSpan(0,2,0,0);
        this.sessionTimeout = createTimeSpan(0,0,20,0);
    </cfscript>
</cfcomponent>
