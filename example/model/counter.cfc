component {

	function init() {
		variables.id = 0;
		return this;
	}
	
	function id() {
		return ++variables.id;
	}

}