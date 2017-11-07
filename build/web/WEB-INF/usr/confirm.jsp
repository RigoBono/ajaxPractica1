<%-- 
    Document   : confirm
    Created on : 29-jul-2017, 13:55:42
    Author     : rigobono
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <link href="favicon.ico" rel="icon"/>
        <title>Nexoto</title>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
        <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>

    <body>
        <div class="container" style="background:blue;">
            <div class="map" id="map">

            </div>

        </div>

        <footer class="footer-page">
            <form method="POST" action="confirmViaje.do">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="text-center pedirViajePestana">
                                <strong>Pedir viaje</strong>
                                <img src="img/icono_circular.png" style="margin-left: 10px;width: 40px;height: 40px">
                            </div>
                        </div>
                    </div>
                    <div class="row datacenter text-center" style="color:blue;padding-bottom: 0px;line-height: 30px;">
                            Esta es una aproximación con fines informativos, el costo real del viaje se actualizará al finalizar el mismo
                        </div>
                    <div class="row datacenter">
                        <div class="col-md-5 ">
                            <label>El viaje tendra un costo inicial de: <strong>$ ${importe}</strong> </label>
                        </div>
                        <div class="col-md-3">
                            <input type="submit" class="form-control inputrow boton" value="Confirmar viaje" >
                        </div>

                        <div class="col-md-3">
                            <input type="button" class="form-control inputrow boton"  onclick="back()" value="Cancelar" >
                        </div>


                    </div>
                        
                        


                </div>
            </form>

        </footer>
        <script>
            function back() {
                var f = document.createElement("form");
                f.setAttribute('method', "post");
                f.setAttribute('action', "backtohome.do");
                document.body.appendChild(f);

                f.submit();
            }


            var origen;
            var destino;




            function initMap() {
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {
                        lat: 20.6605587,
                        lng: -103.348618
                    },
                    zoom: 13
                });
                var input = /** @type {!HTMLInputElement} */ (
                        document.getElementById('pac-input'));
                var input2 = /** @type {!HTMLInputElement} */ (
                        document.getElementById('pac2-input'));



                var types = document.getElementById('type-selector');

                var autocomplete = new google.maps.places.Autocomplete(input);
                var autocomplete2 = new google.maps.places.Autocomplete(input2);
                autocomplete.bindTo('bounds', map);

                var infowindow = new google.maps.InfoWindow();
                var marker = new google.maps.Marker({
                    map: map,
                    anchorPoint: new google.maps.Point(0, -29)
                });

                autocomplete2.addListener('place_changed', function () {
                    var place2 = autocomplete2.getPlace();
                    console.log(place2.geometry.location.lat());
                    origen = place2;
                    console.log(origen);
                    document.getElementById("lat2").value = place2.geometry.location.lat();
                    document.getElementById("lon2").value = place2.geometry.location.lng();
                    document.getElementById("formatedAddress2").value = place2.formatted_address;
                });

                autocomplete.addListener('place_changed', function () {
                    infowindow.close();
                    marker.setVisible(false);
                    var place = autocomplete.getPlace();
                    //console.log(place.geometry.location.lat());
                    destino = place;
                    console.log(destino);
                    document.getElementById("lat1").value = place.geometry.location.lat();
                    document.getElementById("lon1").value = place.geometry.location.lng();
                    document.getElementById("formatedAddress1").value = place.formatted_address;

                    if (!place.geometry) {
                        // User entered the name of a Place that was not suggested and
                        // pressed the Enter key, or the Place Details request failed.
                        window.alert("No details available for input: '" + place.name + "'");
                        return;
                    }

                    if (place.geometry.viewport) {
                        map.fitBounds(place.geometry.viewport);
                    } else {
                        map.setCenter(place.geometry.location);
                        map.setZoom(17);
                    }
                    marker.setIcon(/** @type {google.maps.Icon} */ ({
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

                // Sets a listener on a radio button to change the filter type on Places
                // Autocomplete.
                function setupClickListener(id, types) {
                    var radioButton = document.getElementById(id);
                    radioButton.addEventListener('click', function () {
                        autocomplete.setTypes(types);
                    });
                }

                setupClickListener('changetype-all', []);
                setupClickListener('changetype-address', ['address']);
                setupClickListener('changetype-establishment', ['establishment']);
                setupClickListener('changetype-geocode', ['geocode']);
            }
        </script>
        <!--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyzdP4JK4CSxdn_Ga23S0-cSjBzruOgxE&libraries=places&callback=initAutocomplete" async defer></script>-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyzdP4JK4CSxdn_Ga23S0-cSjBzruOgxE&libraries=places&callback=initMap"
        async defer></script>
    </body>

</html>
