component accessors="true" {

	property name="Method";
	property name="Path";
	property name="Route";
	property name="RouteIndex" default="0";
	property name="Context";
	property name="Views";
	
	function init(required App app) {
		variables.app = app;
		variables.context = new util.StructWrapper().merge(form).merge(url);
		variables.views = new util.StructWrapper({body:""});
		return this;
	}
	
	function incrementRouteIndex() {
		variables.routeindex++;
	}

	
	
}