(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
/**
 * waitFor
 * @param  {String}   selector DOM element to check for on every page load
 * @param  {Function} callback The code to execute when the element is on the page
 * @return {Boolean}
 */
module.exports = function(selector, callback) {
  if (document.querySelectorAll(selector).length > 0) {
    callback();
  } else {
    return false;
  }
};
},{}],2:[function(require,module,exports){
// These are used for the custom map on the locations page
var customMapStyles = [{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#6195a0"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2f2f2"}]},{"featureType":"landscape","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#e6f3d6"},{"visibility":"on"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":-100},{"lightness":45},{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#f4d2c5"},{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"labels.text","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.arterial","elementType":"geometry.fill","stylers":[{"color":"#f4f4f4"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#787878"}]},{"featureType":"road.arterial","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#eaf6f8"},{"visibility":"on"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#eaf6f8"}]}]
module.exports = customMapStyles;
},{}],3:[function(require,module,exports){
var geocodeSearch = function (address, callback) {
	new google.maps.Geocoder().geocode({'address': address}, function(results, status) {
		callback(results, status);
	});
};
module.exports = geocodeSearch;
},{}],4:[function(require,module,exports){
module.exports=(function() {var t = function anonymous(locals, filters, escape, rethrow
/**/) {
escape = escape || function (html){
  return String(html)
    .replace(/&(?!#?[a-zA-Z0-9]+;)/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/'/g, '&#39;')
    .replace(/"/g, '&quot;');
};
var buf = [];
with (locals || {}) { (function(){ 
 buf.push('<ul>\n	');2; litterboxes.forEach(function(litterbox){ ; buf.push('\n		<li style="margin-bottom: 10px;">\n			', escape((4,  litterbox.address_line_1 )), '<br/>\n			');5; if(!!litterbox.address_line_2) { ; buf.push('\n				', escape((6,  litterbox.address_line_2 )), '<br/>\n			');7; } ; buf.push('\n			', escape((8,  litterbox.city )), ', ', escape((8,  litterbox.state )), ' ', escape((8,  litterbox.zip )), '<br/>\n			<a target="_blank" href="http://maps.google.com/?q=', escape((9,  litterbox.full_address )), '">\n				Directions (', escape((10,  litterbox.distance.toFixed(2) )), ' miles)\n			</a>\n		</li>\n	');13; }) ; buf.push('\n</ul>'); })();
} 
return buf.join('');
}; return function(l) { return t(l) }}())
},{}],5:[function(require,module,exports){
var waitFor = require('waitFor'),
		customMapStyles = require('../modules/customMapStyles'),
		geocode = require('../modules/geocode.js');

waitFor('body.searches-show', function() {
	var markers = [],
			$searchForm = $('.search-bar form'),
			$locationField = $searchForm.find('.location'),
			$searchResults = $('#search-results'),
			regularMarker = "/assets/images/regular-marker.png";
			searchResultsTemplate = require('../templates/searchResults.ejs');

	initMap = function() {
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
	},

	initSearch = function() {
		searchLocations();

		$searchForm.submit(function(e){
			e.preventDefault();
			searchLocations();
		});

		google.maps.event.removeListener(idleListener);
	},

	searchLocations = function() {
		var location = $locationField.val();

		if(!!location) {
			geocode(location, function(results, status){
        map.fitBounds(results[0].geometry.viewport);
				getLitterBoxes(map.getCenter().lat(), map.getCenter().lng());
			})
		} else {
			alert('Enter a damn location.');
		}
	},

	getLitterBoxes = function(lat, lng) {
		$.ajax({
			type: 'POST',
			dataType: 'json',
			url: '/search',
			data: {
				lat: lat,
				lng: lng,
			}, success: function(litterboxes) {
				showMarkers(litterboxes);

				$searchResults.html(
					searchResultsTemplate({ litterboxes: litterboxes })
				);
			}}
		);
	},

	showMarkers = function(litterboxes) {
    deleteMarkers();
    litterboxes.forEach(function(litterbox){
    	addMarker(litterbox);
    });
	},

	// Adds a marker to the map and push to the array.
	addMarker = function(litterbox) {
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
	}

	// Deletes all markers in the array by removing references to them.
	deleteMarkers = function() {
		clearMarkers();
		markers = [];
	},

	// Removes the markers from the map, but keeps them in the array.
	clearMarkers = function() {
		setMapOnAll(null);
	},

	// Sets the map on all markers in the array.
	setMapOnAll = function(map) {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(map);
		}
	},

	init = function() {
		initMap();
	};

	init();
});
},{"../modules/customMapStyles":2,"../modules/geocode.js":3,"../templates/searchResults.ejs":4,"waitFor":1}],6:[function(require,module,exports){
var waitFor = require('waitFor'),
		geocode = require('../modules/geocode');

waitFor('body.static_pages-index', function() {
	var $searchForm = $('.search-bar form'),
			$locationField = $searchForm.find('.location');

	init = function() {
		initSearch();
	},

	initSearch = function() {
		$searchForm.submit(function(e){
			var location = $locationField.val();

			if(!location) {
				e.preventDefault();
				alert('Enter a damn location.');
			}
		});
	},

	init();
});
},{"../modules/geocode":3,"waitFor":1}]},{},[5,6]);
