<%-- 
    Document   : inicioAdmin
    Created on : 18-mar-2021, 12:19:37
    Author     : isra9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mamas-inicio</title>

        <%
            // PROTECCION DE RUTAS 

            //Control de login
            if (session.getAttribute("usuarioActual") == null) {
                session.setAttribute("mensaje", "Debes iniciar sesion para acceder a dicha pagina");
                response.sendRedirect("../Vistas/login.jsp");
            } else //Control por rol
            if (((int) session.getAttribute("rolActual")) != 3) {
                session.setAttribute("mensaje", "No tienes permisos para acceder a esa pagina");
                int rol = (int) session.getAttribute("rolActual");
                if (rol == 1) {
                    response.sendRedirect("../Vistas/inicioAlu.jsp");
                }
                if (rol == 2) {
                    response.sendRedirect("../Vistas/inicioProf.jsp");
                }
            }
        %>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <!-- Material Design Bootstrap -->
        <link rel="stylesheet" href="../css/mdb.min.css">
        <!-- Your custom styles (optional) -->
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/all.css">
    </head>
    <body>
        <jsp:include page="../Recursos/navbar.jsp"/>
        <h1>Hello Administrador!</h1>
        <form action="../Controladores/controladorAdmin.jsp" method="POST">
            <input type="submit" name="crudUsuarios" value="Crud Usuarios">
            <input type="submit" name="crudCiclos" value="Crud Ciclos">
            <input type="submit" name="crudMaterias" value="Crud Materias">
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
        <jsp:include page="../Recursos/Footer.jsp"/>
    </body>
</html>
