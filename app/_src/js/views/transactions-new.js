var waitFor = require('waitFor'),
    initDatePicker = require('../modules/datepicker');

waitFor('body.transactions-new', function() {
  initDatePicker($("input#transaction_check_in"));
  initDatePicker($("input#transaction_check_out"));
});
