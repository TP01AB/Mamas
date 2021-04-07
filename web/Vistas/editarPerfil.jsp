<%-- 
    Document   : editarPerfil
    Created on : 06-abr-2021, 16:51:04
    Author     : isra9
--%>

<%@page import="Modelo.Usuario"%>
<%@page import="Modelo.Estudiante"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mamas</title> <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <!-- Material Design Bootstrap -->
        <link rel="stylesheet" href="../css/mdb.min.css">
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/all.css">
    </head>
    <body onload="validarPerfil()" >
        <jsp:include page="../Recursos/navbar.jsp"/>

        <%
            LinkedList<Ciclo> ciclos = (LinkedList<Ciclo>) session.getAttribute("ciclosCompletos");
            Usuario uActual = (Usuario) session.getAttribute("usuarioActual");

        %>
        <div class="card text-center p-4 m-2">
            <% int rol = (int) session.getAttribute("rolActual");

                if (rol == 3) {
            %>

            <form id="perfil" name="perfil" action="../Controladores/controladorAdmin.jsp" method="POST" novalidate>    
                <%
                } else
                %>
                <%if (rol == 1) {
                %>
                <form id="perfil" name="perfil" action="../Controladores/controladorAlumno.jsp" method="POST" novalidate>    
                    <%
                    } else
                    %>
                    <%if (rol == 2) {
                    %>
                    <form id="perfil" name="perfil" action="../Controladores/controladorProfesor.jsp" method="POST" novalidate>    
                        <%
                            }
                        %>
                        <legend>PERFIL</legend>
                        <div class="row mx-auto form-group">
                            <label  for="emailRegistro">Email:</label>
                            <input class=" col-3 " type="email" id="emailRegistro" name="emailRegistro" value="<%= uActual.getEmail()%>"  readonly>
                            <div name="emailRegistroError" class="" id="emailRegistroError" aria-live="polite"></div>
                            <label  for="nombre">Nombre:</label>
                            <input class=" col-3" type="text" id="nombre" name="nombre" value="<%= uActual.getNombre()%>" required minlength="3" >
                            <div name="nombreError" class="" id="nombreError" aria-live="polite"></div>
                            <label   for="apellidos">Apellidos:</label>
                            <input class=" col-3" type="text" id="apellidos" name="apellidos" value="<%= uActual.getApellidos()%>" required >
                            <div name="apellidosError" class="" id="apellidosError" aria-live="polite"></div>
                        </div>
                        <div class="row mx-auto form-group">
                            <label for="dni">DNI:</label>
                            <input type="text" id="dni" name="dni" required value="<%= uActual.getDni()%>" required minlength="9" maxlength="9" pattern="^[0-9]{8}[a-zA-Z]{1}$">
                            <div name="dniError" class="" id="dniError" aria-live="polite"></div>

                            <label for="telefono">Telefono:</label>
                            <input type="number" id="telefono" name="telefono" value="<%= uActual.getTelefono()%>" pattern="^[0-9]{9}$" minlength="9" required>
                            <div name="telefonoError" class="" id="telefonoError" aria-live="polite"></div>

                            <label for="nacimiento">Fecha de nacimiento:</label>
                            <input type="date" id="nacimiento" name="nacimiento" value="<%= uActual.getNacimiento()%>" required>
                            <div name="nacimientoError" class="" id="nacimientoError" aria-live="polite" readonly></div>
                        </div>
                        <input class="btn btn-info" type="submit" name="cambioPass" value="Cambiar contraseña">
                        <input class="btn btn-success" type="submit" name="updatePerfil" value="Guardar cambios">
                    </form>
                    </div>
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
                    <jsp:include page="../Recursos/Footer.jsp"/>
                    </body>
                    </html>
