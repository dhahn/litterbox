var waitFor = require('waitFor'),
    initDatePicker = require('../modules/datepicker');

waitFor('body.transactions-new', function() {
	$.get('/unavailabilities', {litter_box_id: 400}, function(dates) {
	  initDatePicker($("input#transaction_check_in"), dates);
	  initDatePicker($("input#transaction_check_out"), dates);
	});
});
