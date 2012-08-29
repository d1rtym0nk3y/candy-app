component {

	function init() {
		return this;
	}

	function render(required string includepath, context) {
		savecontent variable="local.out" {
			module template="TemplateRenderer.cfm" includepath=arguments.includepath requestcontext=arguments.context;
		}
		return local.out;
	}

}