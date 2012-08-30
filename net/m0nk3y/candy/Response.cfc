component {

	function init(required App app, required Request req) {
		variables.app = app;
		variables.req = req;
		variables.renderer = new net.m0nk3y.candy.template.TemplateRenderer();
		return this;
	}
	
	function render(template, name, append=true) {
		var output = variables.renderer.render(template, req.getContext(), req.getViews());
		if(isNull(arguments.name)) {
			write(output);	
		}
		else {
			if(append) {
				output = req.getViews().get(arguments.name) & output; 
			}
			req.getViews().set(arguments.name, output);
		}
	}
	
	function write(string str) {
		writeoutput(str);
	}

}