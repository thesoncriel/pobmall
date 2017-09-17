<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>Places Autocomplete</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <script src="/js/jquery-1.9.1.min.js"></script>
        <script src="/js/jquery.superLabels.min.js"></script>
        <script src="/js/jquery-ui-1.10.1.custom.min.js"></script>
        <script src="/js/jquery-migrate-1.2.1.min.js"></script>
        <!--[if lt IE 9]><script src="/js/html5shiv.js"></script><![endif]-->
        <script src="/me/mediaelement-and-player.min.js"></script>
        <%--<script src="/me/mediaelement-and-player.js"></script> --%>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>

    <style>
    html, body {
  height: 450px;
  width: 600px;
  margin: 0;
  padding: 0;
}

#map-canvas, #map_canvas {
  height: 100%;
}

@media print {
  html, body {
    height: auto;
  }

  #map-canvas, #map_canvas {
    height: 100%;
  }
}

#panel {
  position: absolute;
  top: 5px;
  left:100px;
  /* left: 50%; */
  /*margin-left: -180px; */
  z-index: 1;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
}

      input {
        border: 1px solid  rgba(0, 0, 0, 0.5);
      }
      input.notfound {
        border: 2px solid  rgba(255, 0, 0, 0.4);
      }
    </style>

    <script>
function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(37.566535, 126.97796919999996),
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
    mapOptions);

  var input = /** @type {HTMLInputElement} */(document.getElementById('searchTextField'));
  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    input.className = '';
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      // Inform the user that the place was not found and return.
      input.className = 'notfound';
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    var sLocation = place.geometry.location.toString();
    var sCoordinate = sLocation.substring(1,sLocation.length-1);
    $("#coordinate").val(sCoordinate);
    
    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }
    
    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });

}

google.maps.event.addDomListener(window, 'load', initialize);


    </script>
    <script type="text/javascript">
    $(document).ready(function(){
    	$("#map_send").click(function(){
    	    $(opener.document).find("#textbox_map_coord").val($("#coordinate").val());
    	    self.close();
    	});
    });
    </script>
  </head>
  <body>
    <div id="panel">
      <input id="searchTextField" type="text" size="60">
    </div>
    <div id="map-canvas"></div>
    <div id="coordinate_view">
    <input type="text" id="coordinate" size="50"/>
    <input type="button" id="map_send" value="좌표사용"/>
    </div>
  </body>
</html>