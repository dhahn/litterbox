var waitFor = require('waitFor'),
		Pikaday = require('../lib/pikaday.js');

waitFor('.date-wrapper', function() {
	var initDatePicker = function() {
		$('.date-wrapper').each(function( index ) {
			$input = $(this).find('input');
			var pickerStart = new Pikaday({
				field: $input[0],
				format: 'MM/DD/YYYY',
				position: 'bottom right',
				firstDay: 0
			});
		});
	};

	var init = function() {
		initDatePicker();
	};

	init();
});