component {

	this.name = hash(getBaseTemplatePath());
	this.sessiontimeout = createtimespan(0,0,30,0);

	this.mappings = {
		"/views" : getDirectoryFromPath(getBaseTemplatePath()) & "/views"
	};

	function onApplicationStart() {
		app = new net.m0nk3y.candy.App();
		foo = new foo();
		
		// default page
		app.get("/", function(req, res, next) {
			res.render("/views/1.cfm", "body");
		});

		app.get("/", function(req, res, next) {
			res.render("/views/1.cfm", "body");
		});


		// example action
		app.get("/something/:foo/:bar", function(req, res, next) {
			req.getContext().setid(foo.id());
			res.render("/views/1.cfm", "body");
		});
		
		
		
		
		
		// sitewide layout
		app.get(".*", function(req, res, next) {
			req.getContext().setid(foo.id());
			res.render("/views/layout.cfm");
		});
		
		application.candy = app;
	}
	
	function onRequestStart() {
		request.s = gettickcount();
//		if(!isNull(url.init)) {
			onApplicationStart();
//		}
	}
	
	function onRequest() {
		application.candy.dispatch();
	}


	function onRequestEnd() {
		writeOutput("<br>" & gettickcount()-request.s);
	}	
	
}