component {

	variables.routes = [];
	
	public function init() {
		return this;
	}

	public function dispatch() {
		var req = new Request(this)
					.setMethod(getRequestMethod())
					.setPath(getPathInfo());

		var res = new Response(this, req);
		
		queueNextRoute(req);
		executeHandlers(req, res);
		
	}
	
	private function executeHandlers(req, res) {
		for(var fn in req.getRoute().handlers) {
			var _break = true;
			fn(req, res, function(what="fn"){
				if(arguments.what == "route") {
					if(queueNextRoute(req)) executeHandlers(req, res);
					_break = true;
				}
				else {
					_break = false;
				}
			});
			if(_break) break;
		}
		
		if(queueNextRoute(req)) executeHandlers(req, res);
		
	}
	
	private function queueNextRoute(req) {
		while(req.getRouteIndex()<=arrayLen(variables.routes)) {
			req.incrementRouteIndex();
			if(req.getRouteIndex() > arrayLen(variables.routes)) return false;
			var r = variables.routes[req.getRouteIndex()];
			if(r.method.equals(req.getMethod()) && r.pattern.matcher(req.getPath()).matches()) {
				req.setRoute(r);
				extractRouteParams(req);
				return true;
			}
		}
		return false;
	}
	
	private function addRoute(method, route, handler) {
		// http methods are upper case
		method = ucase(method);
		// urls are lowercase
		route = lcase(route);
		
		if(!isArray(handler)) handler = [handler];
		for(var i=4; i<=arrayLen(arguments); i++) {
			arrayAppend(handler, arguments[i]);
		}
		
		var routepattern = createRoutePattern(route);
		
		// create route struct for storing
		var r = {
			method: method,
			route: route,
			pattern: routepattern.pattern,
			keys: routepattern.keys,
			handlers: handler
		};
		
		arrayAppend(variables.routes, r);
	}
	
	private function createRoutePattern(route) {
		var slugs = listToArray(route, "/");
		var regex = "";
		var keys = [];
		for(var s in slugs) {
			var match = refindnocase("^:([a-z0-9_-]+)$", s, 1, true);
			if(arraylen(match.len) == 2) {
				var key = mid(s, match.pos[2], match.len[2]);
				arrayappend(keys, key);
				regex &= "/([a-z0-9_-]+)";
				continue;
			}
			regex &= "/#s#";
		}

		regex &= "/?";

		return {
			pattern: createObject("java", "java.util.regex.Pattern").compile(regex),
			keys: keys
		};
	}
	
	private function extractRouteParams(req) {
		var params = {};
		var matches = refind(req.getRoute().pattern.pattern(), req.getPath(), 1, true);
		// first match is the entire string, so start at 2
		var i = 2;
		while(i <= arrayLen(matches.pos)) {
			params[req.getRoute().keys[i-1]] = mid(req.getPath(), matches.pos[i], matches.len[i]);
			i++;
		}
		req.getContext().merge(params);
	}		
	
	private function getRequestMethod() {
		return getHttpRequestData().method;
	}

	public function use(route, handler) {
		if(!isSimpleValue(route)) {
			handler = route;
			route = ".*";
		}
		if(isInstanceOf(handler, "net.m0nk3y.candy.App")) {
		 // TODO: implement this	
		}
		
	}
	
	public function get(route, handler) {
		arguments.method = "GET";
		addRoute(argumentcollection=arguments);
	}
	public function put(route, handler) {
		arguments.method = "PUT";
		addRoute(argumentcollection=arguments);
	}
	
	private function getPathInfo() {
		if(len(cgi.path_info)==0) return "/";
		return cgi.path_info;
	}
	
	

}