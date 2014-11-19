var substringMatcher = function(objs, key) {
	return function findMatches(q, cb) {
		var matches, substrRegex;
 
		// an array that will be populated with substring matches
		matches = [];
	 
		// regex used to determine if a string contains the substring `q`
		substrRegex = new RegExp(q, 'i');
	 
		// iterate through the pool of strings and for any string that
		// contains the substring `q`, add it to the `matches` array
		$.each(objs, function(i, obj) {
			if (substrRegex.test(obj[key])) {
				// the typeahead jQuery plugin expects suggestions to a
				// JavaScript object, refer to typeahead docs for more info
				matches.push(obj);
			}
		});
 
		cb(matches);
	};
};