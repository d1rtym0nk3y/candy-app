<cfif thistag.executionmode eq "start"><cfsilent>
<cfparam name="attributes.includepath" />
<cfset variables.rc = attributes.context />
<cfset variables.views = attributes.views />
</cfsilent><cfinclude template="#attributes.includepath#" /></cfif>