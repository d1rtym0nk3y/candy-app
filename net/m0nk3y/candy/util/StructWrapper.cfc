component {

	function init(context={}) {
		variables.context = arguments.context;
		return this;		
	}
	
	function set(newcontext) {
		variables.context = newcontext;
		return this;
	}

	function merge(newcontext, overwrite=true) {
		structappend(variables.context, newcontext, overwrite);
		return this;
	}
	
	function copyToScope(scope, keys, defaults={}) {
		for(var k in listToArray(keys)) {
			scope[k] = structKeyExists(variables.context, k) ? variables.context[k] : structKeyExists(defaults, k) ? defaults[k] : "";
		}
		return scope;
	}	
	
	function onMissingMethod(missingMethodName,missingMethodArguments) {
		var action = lcase(left(missingMethodName, 3));
		if(action == "get") {
			var key = replaceNoCase(missingMethodName, "get", "", "one");
			var def = structKeyExists(missingMethodArguments, "1") ? missingMethodArguments["1"] : "";
			if(!structKeyExists(variables.context, key)) variables.context[key] = def;
			return variables.context[key];
		}
		if(action == "set") {
			var key = (replaceNoCase(missingMethodName, "set", "", "one"));
			var val = structKeyExists(missingMethodArguments, "1") ? missingMethodArguments["1"] : "";
			variables.context[key] = val;
			return this;
		}
		if(action == "has") {
			var key = replaceNoCase(missingMethodName, "has", "", "one");
			return structKeyExists(variables.context, key);
		}
		throw(message="method #missingMethodName#() was not found, only set{Variable}(value), get{Variable}(defaultValue) or has{Variable}() are supported", type="methodNotFound");
	}

	


}