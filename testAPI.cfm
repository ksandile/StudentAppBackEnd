<cfheader name="Access-Control-Allow-Origin" value="*">
<cfcontent type="application/json">

<cfset testData = {
    message = "ColdFusion is working!",
    status = "ok"
}>

<cfoutput>#serializeJSON(testData)#</cfoutput>
