var waitFor = require('waitFor'),
		geocode = require('../modules/geocode');

waitFor('body.static_pages-index', function() {
	var $searchForm = $('.search-bar form'),
			$locationField = $searchForm.find('.location');

	var init = function() {
		initSearch();
	};

	var initSearch = function() {
		$searchForm.submit(function(e){
			var location = $locationField.val();

			if(!location) {
				e.preventDefault();
				alert('Enter a damn location.');
			}
		});
	};

	init();
});