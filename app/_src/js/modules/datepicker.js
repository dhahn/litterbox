var Pikaday = require('../lib/pikaday.js');

var initDatePicker = function(input) {
  console.log(input[0]);
	new Pikaday({
		field: input[0],
		format: 'MM/DD/YYYY',
		position: 'bottom right',
		firstDay: 0
	});
};

module.exports = initDatePicker;
