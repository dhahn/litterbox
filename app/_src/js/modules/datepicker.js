var Pikaday = require('../lib/pikaday.js');

var initDatePicker = function(input) {
	new Pikaday({
		field: input[0],
		format: 'MM/DD/YYYY',
		position: 'bottom right',
		firstDay: 0
	});
};

module.exports = initDatePicker;
