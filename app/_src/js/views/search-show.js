var waitFor = require('waitFor'),
		customMapStyles = require('../modules/customMapStyles'),
		geocode = require('../modules/geocode.js');

waitFor('body.searches-show', function() {
	var markers = [],
			$searchForm = $('.search-bar form'),
			$locationField = $searchForm.find('.location'),
			$startDateField = $searchForm.find('.start-date'),
			$endDateField = $searchForm.find('.end-date'),
			$searchResults = $('#search-results'),
			regularMarker = '/assets/images/regular-marker.png',
			searchResultsTemplate = require('../templates/searchResults.ejs');

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

		idleListener = google.maps.event.addListener(map, 'idle', initSearch);
	};

	var initSearch = function() {
		searchLocations();

		$searchForm.submit(function(e){
			e.preventDefault();
			searchLocations();
		});

		google.maps.event.removeListener(idleListener);
	};

	var searchLocations = function() {
		var location = $locationField.val();

		if(!!location) {
			geocode(location, function(results, status){
        map.fitBounds(results[0].geometry.viewport);
				getLitterBoxes({
					lat: map.getCenter().lat(),
					lng: map.getCenter().lng(),
					start_date: $startDateField.val(),
					end_date: $endDateField.val(),
				});
			})
		} else {
			alert('Enter a damn location.');
		}
	};

	var getLitterBoxes = function(search_params) {
		$.ajax({
			type: 'POST',
			dataType: 'json',
			url: '/search',
			data: {
				search: search_params,
			}, success: function(litterboxes) {
				showMarkers(litterboxes);

				$searchResults.html(
					searchResultsTemplate({ litterboxes: litterboxes })
				);
			}}
		);
	};

	var showMarkers = function(litterboxes) {
    deleteMarkers();
    litterboxes.forEach(function(litterbox){
    	addMarker(litterbox);
    });
	};

	// Adds a marker to the map and push to the array.
	var addMarker = function(litterbox) {
		icon = regularMarker;

		var marker = new google.maps.Marker({
			position: {
				lat: litterbox.latitude,
				lng: litterbox.longitude
			},
			map: map,
			icon: icon,
		});

		marker.set('litterbox', litterbox);
		markers.push(marker);
	};

	// Deletes all markers in the array by removing references to them.
	var deleteMarkers = function() {
		clearMarkers();
		markers = [];
	};

	// Removes the markers from the map, but keeps them in the array.
	var clearMarkers = function() {
		setMapOnAll(null);
	};

	// Sets the map on all markers in the array.
	var setMapOnAll = function(map) {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(map);
		}
	};

	var init = function() {
		initMap();
	};

	init();
});