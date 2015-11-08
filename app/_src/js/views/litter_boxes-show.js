var waitFor = require('waitFor');

waitFor('body.litter_boxes-show', function() {
	var $body = $('body'),
		$header = $('header'),
		scrolledPastHero = false;

	var init = function() {
		$(document).on('scroll', scrollListen);
	};

	var scrollListen = function () {
		var scrollTop = $body.scrollTop();

		if (scrollTop < 400) {
			if (scrolledPastHero)
				$header.removeClass('opaque');

			scrolledPastHero = false;
			return;
		} else {
			if (scrolledPastHero)
				return;

			scrolledPastHero = true;
			$header.addClass('opaque');
		}
	};

	init();
});