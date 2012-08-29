component accessors="true" {

	property name="Method";
	property name="Path";
	property name="Route";
	property name="RouteIndex" default="0";
	property name="Context";
	
	function init(required App app) {
		variables.app = app;
		variables.context = new util.StructWrapper();
		return this;
	}
	
	function incrementRouteIndex() {
		variables.routeindex++;
	}
	
	function setContext(required struct context) {
		
	}

	
	
}