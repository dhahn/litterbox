var waitFor = require('waitFor');

waitFor('.sign-out-link', function() {
  $('form').on('click', '.sign-out-link', function(event) {
    event.preventDefault();
    $(this).closest('form').submit();
  });
});
