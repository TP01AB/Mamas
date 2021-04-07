<%-- 
    Document   : vistaMateria
    Created on : 07-abr-2021, 3:39:54
    Author     : isra9
--%>

<%@page import="Modelo.Materia"%>
<%@page import="Modelo.Profesor"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MAMAS</title>
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
        <%
            Profesor uActual = (Profesor) session.getAttribute("usuarioActual");
            Ciclo ciclo = (Ciclo) session.getAttribute("cicloElegido");
            Materia materia = (Materia) session.getAttribute("materiaElegida");
        %>
        <div class="m-3 card">
            <div class="card-header bg-secondary">
                <h1><%= ciclo.getNombre()%> (<%= materia.getNombre()%> )</h1>
            </div>
            <div class="card-body">
                <form class="text-center justify-content-center"  action="../Controladores/controladorAlumno.jsp" method="POST" >
                    <input class="btn btn-info" type="submit" name="crudPreguntas" value="Preguntas">
                    <input class="btn btn-info" type="submit" name="CrudExamenes" value="Examenes">
                </form>
            </div>
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
        <script type="text/javascript"></script>
        <jsp:include page="../Recursos/Footer.jsp"/>
    </body>
</html>
