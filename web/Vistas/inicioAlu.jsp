<%-- 
    Document   : inicioAlu
    Created on : 18-mar-2021, 12:19:03
    Author     : isra9
--%>

<%@page import="Modelo.Materia"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="Modelo.Estudiante"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mamas-inicio</title>

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
            LinkedList<Ciclo> ciclos = (LinkedList<Ciclo>) session.getAttribute("ciclosCompletos");
            Estudiante uActual = (Estudiante) session.getAttribute("usuarioActual");
            Ciclo c = uActual.getCiclo();

        %>

        <h1 >Hello <%= uActual.getNombre()%>!</h1>
        <!<!-- Mensaje de error guardado en sesion -->
        <%

            if (session.getAttribute("mensaje") != null) {
                String mensaje = (String) session.getAttribute("mensaje");
        %>
        <hr>
        <div ><span name="mensaje" id="mensaje"><%=mensaje%></span></div>
        <hr>
        <%}%>
        <%
            if (c != null) {
                LinkedList<Materia> materias = c.getMaterias();

                for (int i = 0; i < materias.size(); i++) {
        %>
        <div class="card border-dark m-3 ">
            <div class="card-header">
                <h3 ><%= materias.get(i).getNombre()%></h3>
            </div>
            <div class="card-body">
                <h6> <%= materias.get(i).getDescripcion()%></h6>
            </div>
        </div>

        <%}
        %>
        <form class="text-center justify-content-center"  action="../Controladores/controladorAlumno.jsp" method="POST" >
            <input class="btn btn-success" type="submit" name="convalidar" value="Convalidar asignatura">
            <input class="btn btn-danger" type="submit" name="anularMatricula" value="Anular Matricula">
        </form>
        <%
        } else {%>
        <div class="card m-5  text-center">
            <h1>¿Qué puedes estudiar?</h1>
            <h6>Tenemos la mejor oferta educativa en Formación Profesional Presencial y a Distancia.</h6>
            <hr>
            <table class="table mx-auto">
                <tr >
                    <th class="mx-auto">Nombre</th>
                    <th class="mx-auto">Desripcion</th>
                    <th class="mx-auto">Plazas</th>
                </tr>
                <%
                    for (int j = 0; j < ciclos.size(); j++) {

                %>

                <tr >
                    <td>
                        <p > <%= ciclos.get(j).getNombre()%> </p>
                    </td>

                    <td>
                        <p > <%= ciclos.get(j).getDescripcion()%> </p>
                    </td>
                    <td>
                        <p > <%= ciclos.get(j).getPlazasMaximas()%> </p>
                    </td>
                </tr>

                <%}%>
            </table>
            <form class="text-center justify-content-center"  action="../Controladores/controladorAlumno.jsp" method="POST" >
                <input class="btn btn-success" type="submit" name="matricularme" value="Empezar la matricularme">
            </form>
        </div>
        <%}%>


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
