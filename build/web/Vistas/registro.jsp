<%-- 
    Document   : registro
    Created on : 17-mar-2021, 9:33:46
    Author     : isra9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mamas</title>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <!-- Material Design Bootstrap -->
        <link rel="stylesheet" href="../css/mdb.min.css">
        <!-- Your custom styles (optional) -->
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/all.css">
    </head>
    <body class="container" onload="validarRegistro()">
        <div></div>
        <main>
            <h1>Hello Registro!</h1>
            <!-- Formulario de registro -->
            <form name="registerForm" id="registerForm" action="../Controladores/controlador.jsp" method="POST" novalidate>

                <label for="emailRegistro">Email:</label><br>
                <input type="email" id="emailRegistro" name="emailRegistro" required>
                <span name="emailRegistroError" class="" id="emailRegistroError" aria-live="polite"></span>
                <br>

                <label for="passwordRegistro">Contraseña:</label><br>
                <input type="password" id="passwordRegistro" name="passwordRegistro"  minlength="8" required>
                <div name="passwordRegistroError" class="" id="passwordRegistroError" aria-live="polite"></div>
                <br>

                <hr>
                <label for="nombre">Nombre:</label><br>
                <input type="text" id="nombre" name="nombre" required minlength="3" >
                <div name="nombreError" class="" id="nombreError" aria-live="polite"></div>
                <br>
                <label for="apellidos">Apellidos:</label><br>
                <input type="text" id="apellidos" name="apellidos" required ">
                <div name="apellidosError" class="" id="apellidosError" aria-live="polite"></div>
                <br>
                <label for="dni">DNI:</label><br>
                <input type="text" id="dni" name="dni" required minlength="9" maxlength="9" pattern="^[0-9]{8}[a-zA-Z]{1}$"  required>
                <div name="dniError" class="" id="dniError" aria-live="polite"></div>
                <br>

                <label for="telefono">Telefono:</label><br>
                <input type="text" id="telefono" name="telefono" pattern="^[0-9]{9}$" required>
                <div name="telefonoError" class="" id="telefonoError" aria-live="polite"></div>
                <br>

                <label for="nacimiento">Fecha de nacimiento:</label><br>
                <input type="date" id="nacimiento" name="nacimiento" required>
                <div name="nacimientoError" class="" id="nacimientoError" aria-live="polite" required></div>
                <br>

                <input type="submit" id="registrarseBD" name="registrarseBD" value="registrarse">

            </form>
            <form name="Form" id="Form" action="../Controladores/controlador.jsp" method="POST" >
                <input type="submit" id="home" name="home" value="HOME">
            </form>
        </main>
        <div></div>
        <!-- SCRIPT -->

        <!-- jQuery -->
        <script type="text/javascript" src="../js/jquery.min.js"></script>
        <!-- Bootstrap tooltips -->
        <script type="text/javascript" src="../js/popper.min.js"></script>
        <!-- Bootstrap core JavaScript -->
        <script type="text/javascript" src="../js/bootstrap.min.js"></script>
        <!-- MDB core JavaScript -->
        <script type="text/javascript" src="../js/mdb.min.js"></script>
        <!-- Your custom scripts (optional) -->
        <script type="text/javascript" src="../js/validar.js"></script>
    </body>
</html>
