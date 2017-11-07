<%-- 
    Document   : error
    Created on : 29-jul-2017, 13:42:52
    Author     : rigobono
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>

    <head>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
        <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>

    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4 text-center">
                    <img src="img/icono_circular.png" style="width: 5cm;height: 5cm;">
                </div>
                <div class="col-md-4"></div>
            </div>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4 text-center">
                    <label>Error: ${mensaje} <br></label>
                </div>
                <div class="col-md-4"></div>
            </div>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4 text-center">
                    <label>Da click en la imagen para volver</label>
                </div>
                <div class="col-md-4"></div>
            </div>

        </div>

        <!--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyzdP4JK4CSxdn_Ga23S0-cSjBzruOgxE&libraries=places&callback=initAutocomplete" async defer></script>-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyzdP4JK4CSxdn_Ga23S0-cSjBzruOgxE&libraries=places&callback=initMap"
        async defer></script>
    </body>

</html>
