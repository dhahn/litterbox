var waitFor = require('waitFor'),
		customMapStyles = require('../modules/customMapStyles');

waitFor('body.searches-show', function() {
	var initMap = function() {
		var mapOptions = {
			zoom: 4,
			center: new google.maps.LatLng(39.50, -98.35),
			mapTypeControl: false,
			disableDefaultUI: true,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
		};


		map = new google.maps.Map($('#map')[0], mapOptions);

		// set up custom styled map
		styledMap = new google.maps.StyledMapType(customMapStyles, {name: 'Hairbnb Map'});
		map.mapTypes.set('map_style', styledMap);
		map.setMapTypeId('map_style');

		// idleListener = google.maps.event.addListener(map, 'idle', firstIdle);
	},

	init = function() {
		initMap();
	}

	init();
});