<cfset studentService = createObject("component", "Student")>

<cfset result = studentService.loginStudent(
    sEmail = trim(form.sEmail),
    sPassword = trim(form.sPassword)
)>

<cfoutput>#serializeJSON(result)#</cfoutput>
