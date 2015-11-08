var geocodeSearch = function (params, callback) {
	new google.maps.Geocoder().geocode(params, function(results, status) {
		callback(results, status);
	});
};
module.exports = geocodeSearch;