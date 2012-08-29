<cfif thistag.executionmode eq "start"><cfsilent>
<cfparam name="attributes.includepath" />
<cfset variables.rc = attributes.requestcontext />
</cfsilent><cfinclude template="#attributes.includepath#" /></cfif>