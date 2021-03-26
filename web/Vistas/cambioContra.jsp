<%-- 
    Document   : cambioContra
    Created on : 23-mar-2021, 9:10:41
    Author     : isra9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mamas</title> <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <!-- Material Design Bootstrap -->
        <link rel="stylesheet" href="../css/mdb.min.css">
        <!-- Your custom styles (optional) -->
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/all.css">
    </head>
    <body class="container" onload="validarCambio()">
        <div></div>
        <main>
            <h1>Hello Cambio de contraseña!</h1>
            <!-- Formulario de contraseña olvidada -->
            <form name="changeForm" action="../Controladores/controlador.jsp" method="POST" novalidate>
                <label for="passwordChange"> Contraseña:</label>
                <input type="password" id="passwordChange" name="passwordChange" minlength="8" required>
                <span name="passwordChangeError1" class="" id="passwordChangeError1" aria-live="polite"></span>
                
                <label for="password2Change">Repite la contraseña:</label>
                <input type="password" id="password2Change" name="password2Change" minlength="8" required >
                <span name="passwordChangeError2" class="" id="passwordChangeError2" aria-live="polite"></span>
                <input type="submit" id="passwordChange" name="passwordChange" value="Cambio contraseña">
            </form>
            <form name="Form" id="loginForm" action="../Controladores/controlador.jsp" method="POST" >
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
