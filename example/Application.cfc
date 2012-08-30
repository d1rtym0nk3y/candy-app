component {

	this.name = hash(getBaseTemplatePath());
	this.sessiontimeout = createtimespan(0,0,30,0);

	this.mappings = {
		"/views" : getDirectoryFromPath(getBaseTemplatePath()) & "/views"
	};

	function onApplicationStart() {
		var app = new net.m0nk3y.candy.App();
		
		var menu = function(req,res,next) {
			res.render("/views/menu.cfm", "menu");
			next();
		};
		
		var layout = function(req, res, next) {
			res.render("/views/layout.cfm");
			next();
		};
		
		// default page
		app.get("/", function(req, res, next) {
			res.render("/views/home.cfm", "body");
		});


		var main = new example.module.main.main(app);
		main.load();

		
		// sitewide layout
		app.get(".*", [menu,layout]);
		
		
		
		
		application.candy = app;
	}
	
	function onRequestStart() {
		url.init = 1;
		if(!isNull(url.init)) {
			onApplicationStart();
		}
	}
	
	function onRequest() {
		application.candy.dispatch();
	}
	

	
}