var waitFor = require('waitFor'),
		customMapStyles = require('../modules/customMapStyles'),
		geocode = require('../modules/geocode.js'),
		moment = require('moment');

waitFor('body.searches-show', function() {
	var paginationPageAmount = 3,
			paginationPage = 1,
			infowindow,
			markers = [],
			returned_litterboxes = [],
			$searchForm = $('.search-bar form'),
			$locationField = $searchForm.find('.location'),
			$startDateField = $searchForm.find('.start-date'),
			$endDateField = $searchForm.find('.end-date'),
			$radiusField = $searchForm.find('#radius'),
			$searchResults = $('#search-results'),
			$searchResultsContainer = $('.sec-search .results'),
			$filterForm = $('#filters'),
			$numberOfCatsField = $filterForm.find('#number_of_cats'),
			$kidFriendlyField = $filterForm.find('#kid_friendly'),
			regularMarker = '/assets/images/regular-marker.png',
			searchResultsTemplate = require('../templates/searchResults.ejs'),
			singleSearchResults = require('../templates/singleSearchResults.ejs');


	var initMap = function() {
		var mapOptions = {
			zoom: 4,
			center: new google.maps.LatLng(39.50, -98.35),
			mapTypeControl: false,
			disableDefaultUI: true,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
		};
		map = new google.maps.Map($('#map')[0], mapOptions);

		infowindow = new google.maps.InfoWindow({
			content: "holding..."
		})

		// set up custom styled map
		styledMap = new google.maps.StyledMapType(customMapStyles, {name: 'Litterbox Map'});
		map.mapTypes.set('map_style', styledMap);
		map.setMapTypeId('map_style');

		idleListener = google.maps.event.addListener(map, 'idle', initSearch);
	};

	var initUpdateEndDate = function() {
		$startDateField.change(function(){
			endDate = moment($endDateField.val());
			startDate = moment(this.value);

			if($endDateField.val() == "" || endDate < startDate) {
				$endDateField.val(startDate.add(1, 'days').format('L'));
			}
		});
	};

	var initFilter = function() {
		$filterForm.find('input, select').change(function(){
			displayMarkers(returned_litterboxes);
		});
	};

	var initPagination = function() {
		$searchResults.on('click tap touch', '#load-more', function(e){
			e.preventDefault();

			paginationPage += 1
			if((paginationPage * paginationPageAmount) >= markers.length) {
				$('#load-more').hide();
			}

			markers.slice((paginationPage - 1) * paginationPageAmount, paginationPage * paginationPageAmount).forEach(function(marker){
				$('.results-list').append(singleSearchResults({ litterbox: marker.litterbox }));
			})
		})
	};

	var filterLitterBox = function(litterbox) {
		return filterNumberofCats(litterbox)
			&& filterKidFriendly(litterbox);
	};

	var filterKidFriendly = function(litterbox) {
		return !($kidFriendlyField.prop('checked') && litterbox.number_of_children > 0)
	};

	var filterNumberofCats = function(litterbox) {
		return $numberOfCatsField.val() <= litterbox.capacity;
	};

	var initSearch = function() {
		searchLitterBoxes();

		$searchForm.submit(function(e){
			e.preventDefault();
			searchLitterBoxes();
		});

		google.maps.event.removeListener(idleListener);
	};

	var searchLitterBoxes = function() {
		var location = $locationField.val();

		if(!!location) {
			geocode(location, function(results, status){
        map.fitBounds(results[0].geometry.viewport);
				getLitterBoxes({
					lat: map.getCenter().lat(),
					lng: map.getCenter().lng(),
					start_date: $startDateField.val(),
					end_date: $endDateField.val(),
					radius: $radiusField.val(),
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
				displayMarkers(litterboxes);
			}}
		);
	};

	var displayMarkers = function(litterboxes) {
		paginationPage = 1;
		returned_litterboxes = litterboxes;
		showMarkers(returned_litterboxes);

		$searchResults.html(
			searchResultsTemplate({ markers: markers.slice((paginationPage - 1) * paginationPageAmount, paginationPage * paginationPageAmount), count: markers.length })
		);
		$searchResultsContainer.animate({ scrollTop: 0 });
	};

	var showMarkers = function(litterboxes) {
		deleteMarkers();
    litterboxes.forEach(function(litterbox){
    	if(filterLitterBox(litterbox)) {
	    	addMarker(litterbox);
    	}
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

		google.maps.event.addListener(marker, 'click', function () {
			infowindow.setContent('hello world');
			infowindow.open(map, this);
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
		initFilter();
		initUpdateEndDate();
		initPagination();
	};

	init();
});