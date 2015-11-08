var waitFor = require('waitFor'),
    customMapStyles = require('../modules/customMapStyles'),
    geocode = require('../modules/geocode.js'),
    moment = require('moment');

waitFor('body.litter_boxes-new', function() {
  var $litterboxName = $("#litter_box_name");
  var $litterboxCapacity = $("#litter_box_capacity");
  var $litterboxDescription = $("#litter_box_description");
  var $litterboxCity = $("#litter_box_city");
  var $litterboxPrice = $("#litter_box_price");
  var $litterboxState = $("#litter_box_state");
  var $litterboxAddressOne = $("#litter_box_address_line_1");
  var $litterboxAddressTwo = $("#litter_box_address_line_2");
  var $litterboxZip = $("#litter_box_zip");
  var $litterboxNumberAdults = $("#litter_box_numbers_of_adults");
  var $litterboxNumberChildren = $("#litter_box_numbers_of_children");
  var $litterboxNumberPets = $("#litter_box_numbers_of_pets");
  var $latitude = $("#litter_box_latitude").val();
  var $longitude = $("#litter_box_longitude").val();
  var myLatLng = function(){ return { lat: $latitude.val(), lng: $longitude.val() }};
  var regularMarker = '/assets/images/regular-marker.png';
  var map;

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

    var idleListener = google.maps.event.addListener(map, 'idle', function(){
      if(!!locationValuesCache()){
        geocode(locationValuesCache(), function(results, status){
          map.fitBounds(results[0].geometry.viewport);
        });
        $latitude = map.getCenter().lat();
        $longitude = map.getCenter().lng();
      }
        google.maps.event.removeListener(idleListener);
    });
  };

  function locationValuesCache() {
    return $litterboxAddressOne.val() +
      $litterboxAddressTwo.val() +
      $litterboxCity.val() +
      $litterboxState.val() +
      $litterboxZip.val();
  };

  $('form input').change(function(){
    geocode(locationValuesCache(), function(results, status) {
      map.fitBounds(results[0].geometry.viewport);
      icon = regularMarker;
      marker = new google.maps.Marker({
        position: {lat: map.getCenter().lat(), lng: map.getCenter().lng()}, 
        map: map,
        icon: icon
      });
    });
  });

  var init = function() {
    initMap();
  };

  init();
});