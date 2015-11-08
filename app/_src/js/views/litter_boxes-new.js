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
  var currentLocation = {
    address: ' ',
    addressTwo: '',
    city: ' ',
    state: ' ',
    zip: ' ',
    value: function() { return this.address + " " + this.addressTwo+ " " + this.city + ", " + this.state + " " +this.zip }
  };
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
      geocode(currentLocation.value(), function(results, status){
        map.fitBounds(results[0].geometry.viewport);
      });
      map.getCenter().lat()
      map.getCenter().lng()
    });
  };

  $litterboxCity.on('change', function(){
    console.log('hey');
    currentLocation.city = $litterboxCity.val() || ' ';
    geocode(currentLocation.value(), function(results, status){
      map.fitBounds(results[0].geometry.viewport);
    });
  });

  $litterboxAddressOne.on('change', function(){
    console.log('hey');
    currentLocation.address = $litterboxAddressOne.val() || ' ';
    console.log(currentLocation)
    geocode(currentLocation.value(), function(results, status){
      map.fitBounds(results[0].geometry.viewport);
    });
  });

  $litterboxState.on('change', function(){
    console.log('hey');
    currentLocation.state = $litterboxState.val() || ' ' ;
    console.log(currentLocation)
    geocode(currentLocation.value(), function(results, status){
      map.fitBounds(results[0].geometry.viewport);
    });
  });

  $litterboxZip.on('change', function(){
    console.log('hey');
    currentLocation.zip = $litterboxZip.val() || ' ';
    console.log(currentLocation)
    geocode(currentLocation.value(), function(results, status){
      map.fitBounds(results[0].geometry.viewport);
    });
  });

  var init = function() {
    initMap();
  };

  init();
});