component {

	function init(required App app, required Request req) {
		variables.app = app;
		variables.req = req;
		variables.renderer = new net.m0nk3y.candy.template.TemplateRenderer();
		return this;
	}
	
	function render(template, name) {
		var output = variables.renderer.render(template, req.getContext());
		if(isNull(name)) {
			writeOutput(output);	
		}
		else {
			req.getContext()["set#name#"](output);
		}
	}
	
	function write(string str) {
		writeoutput(str);
	}

}