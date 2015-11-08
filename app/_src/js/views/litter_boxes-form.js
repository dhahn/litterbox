var waitFor = require('waitFor'),
		initDatePicker = require('../modules/datepicker');

waitFor('body.litter_boxes-new, body.litter_boxes-edit','body.transactions-new', function() {
	var initAddFields = function() {
		$('form').on('click', '.add_fields', function(event) {
			var time = new Date().getTime();
			var regexp = new RegExp($(this).data('id'), 'g');
			var el = $($(this).data('fields').replace(regexp, time))
			$(this).before(el);
			el.find('.date-wrapper').each(function( index ) {
				initDatePicker($(this).find('input'))
			});
			event.preventDefault();
		});
	};

	var initRemoveFields = function() {
		$('form').on('click', '.remove_fields', function(event) {
			$(this).prev('input[type=hidden]').val('1')
			$(this).closest('fieldset').hide()
			event.preventDefault()
		});
	};

	var init = function() {
		initAddFields();
		initRemoveFields();
	};

	init();
});
