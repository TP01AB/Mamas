<%-- 
    Document   : convalidar
    Created on : 05-abr-2021, 23:07:21
    Author     : isra9
--%>

<%@page import="Modelo.Materia"%>
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
            Estudiante uActual = (Estudiante) session.getAttribute("usuarioActual");
            Ciclo c = uActual.getCiclo();
            LinkedList<Materia> materias = c.getMaterias();
        %>
        <form class=" card m-5 p-5  align-content-center "  action="../Controladores/controladorAlumno.jsp" method="POST" validate>
            <legend>Convalidacion</legend>
            <hr>
            <%
                for (int i = 0; i < materias.size(); i++) {
            %>
            <label><input type="checkbox" name="materia" value="<%= materias.get(i).getId()%>" > <%= materias.get(i).getNombre()%></label> <p><%=materias.get(i).getDescripcion()%></p> <br>
            <hr> 
            <%}
            %>
            <input class="btn btn-success" type="submit" name="convalidarBD" value="Enviar matricula.">
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
