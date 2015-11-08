var Pikaday = require('../lib/pikaday.js'),
		moment = require('moment');

var initDatePicker = function(input, unavailable_days) {
	new Pikaday({
		field: input[0],
		format: 'MM/DD/YYYY',
		position: 'bottom right',
		firstDay: 0,
		disableDayFn: function(day) {
			if(!!unavailable_days) {
				return unavailable_days.indexOf(moment(day).format('YYYY-MM-DD')) > -1;
			}

			return false;
		}
	});
};

module.exports = initDatePicker;
