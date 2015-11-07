var geocodeSearch = function (address, callback) {
	new google.maps.Geocoder().geocode({'address': address}, function(results, status) {
		callback(results, status);
	});
};
module.exports = geocodeSearch;