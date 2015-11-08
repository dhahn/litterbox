var waitFor = require('waitFor'),
    customMapStyles = require('../modules/customMapStyles'),
    geocode = require('../modules/geocode.js'),
    moment = require('moment');

waitFor('body.litter_boxes-new', function() {
  $litterboxName = $("litter_box_name");
  $litterboxCapacity = $("litter_box_capacity");
  $litterboxDescription = $("litter_box_description");
  $litterboxCity = $("litter_box_city");
  $litterboxPrice = $("litter_box_price");
  $litterboxState = $("litter_box_state");
  $litterboxAddressOne = $("litter_box_address_line_1");
  $litterboxAddressTwo = $("litter_box_address_line_2");
  $litterboxZip = $("litter_box_zip");
  $litterboxNumberAdults = $("litter_box_numbers_of_adults");
  $litterboxNumberChildren = $("litter_box_numbers_of_children");
  $litterboxNumberPets = $("litter_box_numbers_of_pets");
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
  };
  var init = function() {
    initMap();
  };
  
  init();
});