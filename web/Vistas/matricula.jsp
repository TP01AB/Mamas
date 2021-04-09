<%-- 
    Document   : matricula
    Created on : 05-abr-2021, 20:58:42
    Author     : isra9
--%>

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
        <!-- Your custom styles (optional) -->
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/all.css">
    </head>
    <body class="vw-100">
        <jsp:include page="../Recursos/navbar.jsp"/>

        <%
            LinkedList<Ciclo> ciclos = (LinkedList<Ciclo>) session.getAttribute("ciclosCompletos");
            Estudiante uActual = (Estudiante) session.getAttribute("usuarioActual");

        %>
        <form class="col-12 card text-center justify-content-center"  action="../Controladores/controladorAlumno.jsp" method="POST" validate>
            <legend>MATRICULA</legend>
            <div class="row mx-auto form-group">
                <label  for="emailRegistro">Email:</label>
                <input class=" col-3 " type="email" id="emailRegistro" name="emailRegistro" value="<%= uActual.getEmail()%>" readonly>
                <label  for="nombre">Nombre:</label>
                <input class=" col-3" type="text" id="nombre" name="nombre" value="<%= uActual.getNombre()%>" readonly>
                <label   for="apellidos">Apellidos:</label>
                <input class=" col-3" type="text" id="apellidos" name="apellidos" value="<%= uActual.getApellidos()%>" readonly >
            </div>
            <div class="row mx-auto form-group">
                <label for="dni">DNI:</label>
                <input type="text" id="dni" name="dni" required value="<%= uActual.getDni()%>"  readonly>
                <div name="dniError" class="" id="dniError" aria-live="polite"></div>

                <label for="telefono">Telefono:</label>
                <input type="text" id="telefono" name="telefono" value="<%= uActual.getTelefono()%>" readonly>
                <div name="telefonoError" class="" id="telefonoError" aria-live="polite"></div>

                <label for="nacimiento">Fecha de nacimiento:</label>
                <input type="date" id="nacimiento" name="nacimiento" value="<%= uActual.getNacimiento()%>" readonly>
                <div name="nacimientoError" class="" id="nacimientoError" aria-live="polite" readonly></div>
            </div>
            <div class="row mx-auto form-group">
                <label for="nota">nota acceso:</label>
                <input type="number" id="nota" name="nota" step=".01" min="5" max="10" required>

                <select class="m-1" name="ciclo">
                    <%
                        for (int j = 0; j < ciclos.size(); j++) {%>
                    <option  value="<%=ciclos.get(j).getId_ciclo()%>"><%=ciclos.get(j).getNombre()%></option>
                    <%
                        }
                    %>
                </select>

            </div>

            <input class="btn btn-success" type="submit" name="matriculaDB" value="Enviar matricula.">
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
