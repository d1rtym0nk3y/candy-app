component {

	function init() {
		return this;
	}

	function render(required string includepath, context, views) {
		savecontent variable="local.out" {
			module 	template="TemplateRenderer.cfm" 
					includepath=arguments.includepath 
					context=arguments.context
					views=arguments.views;
		}
		return local.out;
	}

}