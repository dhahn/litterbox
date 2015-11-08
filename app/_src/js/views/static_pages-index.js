var waitFor = require('waitFor'),
		geocode = require('../modules/geocode');

waitFor('body.static_pages-index', function() {
	var $searchForm = $('.search-bar form'),
			$locationField = $searchForm.find('.location'),
			$hero = $('.sec-hero'),
			$body = $('body'),
			$header = $('header'),
			$faqButton = $('.faq-button'),
			$faqSection = $('#faq'),
			heroHeight,
			scrolledPastHero = false;

	var init = function() {
		initSearch();

		$('header').addClass('animated fadeInDown');
		$('.sec-hero .headline').addClass('animated fadeIn');
		$locationField.on('focus', function () {
			$locationField.removeClass('animated shake invalid');
		});

		heroHeight = $hero.height() - 78; // aw yis, hardcode that mug
		$(document).on('scroll', scrollListen);

		$faqButton.on('click', function (e) {
			e.preventDefault();
			$body.animate({ scrollTop: $faqSection.offset().top }, 1000);
		});
	};

	var scrollListen = function () {
		var scrollTop = $body.scrollTop(),
			heroOffset = 0;

		if (scrollTop < heroHeight) {
			// Do some basic parallax
			heroOffset = 25 + ((scrollTop / heroHeight) * 20);
			$hero.css('background-position', '50% ' + heroOffset + '%');

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

	var initSearch = function() {
		$searchForm.submit(function(e){
			var location = $locationField.val();

			if(!location) {
				e.preventDefault();
				$locationField.addClass('animated shake invalid');
			}
		});
	};

	init();
});