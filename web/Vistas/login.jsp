<%-- 
    Document   : login
    Created on : 17-mar-2021, 9:33:32
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
    <body onload="validacionLogin()" class="container">
        <div class=""></div>
        <main class="justify-content-center">
            <h1>Hello Login!</h1>
            <!-- Formulario de inicio sesion -->
            <form name="loginForm" id="loginForm" action="../Controladores/controlador.jsp" method="POST" novalidate>
                <label for="emailLogin">Email:</label><br>
                <input type="email" id="emailLogin" name="emailLogin" required>
                <span name="emailLoginError" class="" id="emailLoginError" aria-live="polite"></span>
                <br>

                <label for="passwordLogin">Contraseña:</label><br>
                <input type="password" id="passwordLogin" name="passwordLogin" required minlength="8">
                <span name="passwordLoginError" class="" id="passwordLoginError" aria-live="polite"></span>
                <br>


                <!<!-- Mensaje de error guardado en sesion -->
                <%

                    if (session.getAttribute("mensaje") != null) {
                        String mensaje = (String) session.getAttribute("mensaje");
                %>
                <hr>
                <div ><span name="mensaje" id="mensaje"><%=mensaje%></span></div>
                <hr>
                <%
                    }
                %>
                <br>
                <input type="submit" id="iniciarseBD" name="iniciarseBD" value="inicar sesion">

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
