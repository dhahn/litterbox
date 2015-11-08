var waitFor = require('waitFor');

waitFor('.sidebar-container', function() {
	var $body = $('body');
	var $sidebarContainer = $('.sidebar-container');
	var $sidebarSignIn = $('.sidebar.new-session');
	var $sidebarSignUp = $('.sidebar.new-registration');
	var $linkSignIn = $('a.sign-in');
	var $linkSignUp = $('a.sign-up');

	$sidebarContainer.click(function (e) {
		if (!$(e.target).hasClass('sidebar-container'))
			return;

		$body.removeClass('sidebar-open');
		$sidebarContainer.removeClass('animated fadeIn');

		$sidebarSignIn.removeClass('animated fadeInLeftBig');
		$sidebarSignUp.removeClass('animated fadeInLeftBig');
	});

	$linkSignIn.click(function (e) {
		e.preventDefault();

		$body.addClass('sidebar-open');
		$sidebarContainer.addClass('animated fadeIn');

		$sidebarSignIn
			.addClass('animated fadeInLeftBig')
			.find('input[type="email"]').focus();
	});

	$linkSignUp.click(function (e) {
		e.preventDefault();

		$body.addClass('sidebar-open');
		$sidebarContainer.addClass('animated fadeIn');

		$sidebarSignIn.removeClass('animated fadeInLeftBig');
		$sidebarSignUp
			.addClass('animated fadeInLeftBig')
			.find('input[type="email"]').focus();
	});

});
