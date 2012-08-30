component {

	function init(required App app) {
		variables.app = app;
		return this;
	}
	
	function load() {
		
		app.get("/edit/:id", function(req,res,next){
			savecontent variable="foo" {
				writeDump(req);
			}
			req.getViews().setBody(foo);
		});
		
		
	}
	
	
	
	

}