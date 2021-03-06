<%-- 
    Document   : home
    Created on : 08-ago-2017, 23:34:07
    Author     : rigobono
--%>

<%@page import="org.json.JSONObject"%>
<%@page import="com.nexoto.dao.viajeDAO"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.nexoto.beans.Usuario"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.nexoto.hbm.HibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>

    <head>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/lightbox.css" />
        <link href="favicon.ico" rel="icon"/>
        <title>Nexoto</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
        <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    </head>

    <body>
        <div class="container" style="background:blue;">
            <div class="modal"  id="reporte">
                <div class="row">
                    <div class="col-md-2 col-md-offset-10 text-left" style="color:white;cursor: pointer;" onclick="closeModal()">
                        CERRAR
                    </div>
                </div>
                <div class="row">

                    <div class="col-md-10 col-md-offset-1" style="background: white;" id="report">
                        <div class="table-responsive">
                            <table class="table">
                                <tr>
                                    <th>Id</th>
                                    <th>Estatus</th>
                                    <th>Origen</th>
                                    <th>Destino</th>
                                    <th>Hora del servico</th>
                                    <th>Distancia (km)</th>
                                    <th>Costo para la empresa (Se actualizara hasta que el viaje este como Terminado)</th>
                                    <th>Referencia</th>
                                    <th>Nombre del pasajero</th>
                                    <th>Telefono del pasajero</th>
                                    <th>Correo del pasajero</th>
                                    <th>Chofer</th>
                                </tr>
                                <%
                                    HttpSession misession = request.getSession();
                                    Usuario user = (Usuario) misession.getAttribute("usuario");
                                    JSONArray js = viajeDAO.getReporteViajesPerUser(user.getIdusuario());
                                    System.out.println(js.toString());
                                    for (int i = 0; i < js.length(); i++) {
                                        JSONObject json = js.getJSONObject(i);
                                        out.print("<tr>\n"
                                                + "                                    <td>" + json.getInt("id") + "</td>\n"
                                                + "                                    <td>" + json.getString("Estatus") + "</td>\n"
                                                + "                                    <td>" + json.getString("Origen") + "</td>\n"
                                                + "                                    <td>" + json.getString("Destino") + "</td>\n"
                                                + "                                    <td>" + json.getString("HoraSolicitud") + "</td>\n"
                                                + "                                    <td>" + json.getString("Distancia") + "</td>\n"
                                                + "                                    <td>$" + json.getDouble("Costo") + "</td>\n"
                                                + "                                    <td>" + json.getString("referencia") + "</td>\n"
                                                + "                                    <td>" + json.getString("NombrePasajero") + "</td>\n"
                                                + "                                    <td>" + json.getString("TelefonoPasajero") + "</td>\n"
                                                + "                                    <td>" + json.getString("CorreoPasajero") + "</td>\n"
                                                + "                                    <td>" + json.getString("Chofer") + "</td>\n"
                                                + "                                </tr>");
                                    }
                                %>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
            <div class="map" id="map">

            </div>

        </div>

        <footer class="footer-page">
            <form method="POST" action="pedirViaje.do"  accept-charset="ISO-8859-1">
                <div class="container">
                    <div class="row">
                        <div class="col-md-2">
                            <div class="text-center pedirViajePestana">
                                <strong>Viajar</strong>
                                <img src="img/icono_circular.png" style="margin-left: 10px;width: 20px;height: 20px">
                            </div>
                        </div>
                        <div class="col-md-2" style="margin-left: 0px;">
                            <div class="text-center pedirViajePestana" onclick="showModal()">
                                <strong>Tus viajes</strong>
                            </div>
                        </div>
                        
                    </div>
                    <div class="row datacenter">
                        <div class="col-md-4 ">
                            <input type="text"  class="form-control inputrow" placeholder="A donde vamos?" id="pac-input" required>
                            <input type="hidden" id="lat1" name="lat1" value="">
                            <input type="hidden" id="lon1" name="lon1" value="">
                            <input type="hidden" id="formatedAddress1" name="formatedAddress1" value="">
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="nombrePasajero" class="form-control inputrow" placeholder="Nombre del pasajero"   id="nombre" required>
                        </div>
                        <div class="col-md-4">
                            <input type="number" name="telefonoPasajero" class="form-control inputrow"  id="telefono" placeholder="Telefono contacto" >
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="" class="form-control inputrow" placeholder="Donde te recogemos?" id="pac2-input">
                            <input type="hidden" id="lat2" name="lat2" value="">
                            <input type="hidden" id="lon2" name="lon2" value="">
                            <input type="hidden" id="formatedAddress2" name="formatedAddress2" value="">
                        </div>
                        <div class="col-md-4">
                            <input type="email" name="correoPasajero" class="form-control inputrow" placeholder="Email contacto" >
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="observaciones" class="form-control inputrow" placeholder="Referencia" required>
                        </div>
                        <div class="col-md-4" >
                            <div class="checkbox" style="line-height: normal;padding-top: 10px;">
                                <label><input type="checkbox" value="" name="empresa_paga">La empresa pagara el viaje</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <input type="submit" class="form-control inputrow boton" value="Pedir viaje" >
                        </div>
                    </div>


                </div>
            </form>

        </footer>
        <script>

        </script>
        <script>


            function showModal() {
                document.getElementById("reporte").style.display = "block";
            }

            function closeModal() {
                document.getElementById("reporte").style.display = "none";
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
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCGpH2Ti6meGNabrryA96InK-YpRNa0mPc&libraries=places&callback=initMap" async defer></script>
    </body>

</html>