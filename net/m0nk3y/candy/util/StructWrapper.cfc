component {

	function init(context={}) {
		variables.context = arguments.context;
		return this;		
	}
	
	function set(key, value) {
		variables.context[arguments.key] = arguments.value;
		return this;
	}
	
	function get(key, defaultValue) {
		if(!has(arguments.key) && !isNull(defaultValue)) {
			set(arguments.key, arguments.defaultValue);
		}
		if(has(arguments.key)) {
			return variables.context[arguments.key];
		}
	}
	
	function has(key) {
		return structKeyExists(variables.context, arguments.key);
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
			return get(key, def);
		}
		if(action == "set") {
			var key = (replaceNoCase(missingMethodName, "set", "", "one"));
			var val = structKeyExists(missingMethodArguments, "1") ? missingMethodArguments["1"] : "";
			return set(key, val);
		}
		if(action == "has") {
			var key = replaceNoCase(missingMethodName, "has", "", "one");
			return has(key);
		}
		throw(message="method #missingMethodName#() was not found, only set{Variable}(value), get{Variable}(defaultValue) or has{Variable}() are supported", type="methodNotFound");
	}

	


}