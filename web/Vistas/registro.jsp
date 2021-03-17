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
        <title>JSP Page</title>
         <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <!-- Material Design Bootstrap -->
        <link rel="stylesheet" href="../css/mdb.min.css">
        <!-- Your custom styles (optional) -->
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/all.css">
    </head>
    <body>
        <h1>Hello Registro!</h1>
        
         <!-- Formulario de registro -->
        <form name="loginForm" action="../Controladores/controlador.jsp" method="POST">
            <input type="email" id="emailRegistro" name="emailRegistro" >
            <input type="password" id="passwordRegistro" name="passwordRegistro">
            <input type="submit" id="registrarseBD" name="registrarseBD" value="registrarse">
            <input type="submit" id="home" name="home" value="HOME">
        </form>
        
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
        <script type="text/javascript"></script>
    </body>
</html>
