var waitFor = require('waitFor'),
    initDatePicker = require('../modules/datepicker');

waitFor('body.transactions-new, body.litter_boxes-show', function() {
	$.get('/unavailabilities', {litter_box_id: $('#transaction_litter_box_id').val()}, function(dates) {
	  initDatePicker($("input#transaction_check_in"), dates);
	  initDatePicker($("input#transaction_check_out"), dates);
	});
});
