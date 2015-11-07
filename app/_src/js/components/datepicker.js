var waitFor = require('waitFor'),
		initDatePicker = require('../modules/datepicker');

waitFor('.date-wrapper', function() {
	$('.date-wrapper').each(function( index ) {
		initDatePicker($(this).find('input'));
	});
});
