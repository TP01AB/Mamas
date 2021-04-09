<%-- 
    Document   : inicioProf
    Created on : 18-mar-2021, 12:19:17
    Author     : isra9
--%>

<%@page import="Modelo.Ciclo"%>
<%@page import="Modelo.Materia"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Profesor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mamas-inicio</title>
        <%
            // PROTECCION DE RUTAS 

            //Control por rol
            if (((int) session.getAttribute("rolActual")) == 1) {
                session.setAttribute("mensaje", "No tienes permisos para acceder a esa pagina");

                response.sendRedirect("../Vistas/inicioAlu.jsp");
            }
            Profesor p = (Profesor) session.getAttribute("usuarioActual");
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
        <%
            Profesor uActual = (Profesor) session.getAttribute("usuarioActual");
            LinkedList<Ciclo> ciclos = (LinkedList<Ciclo>) uActual.getCiclos();
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
            for (int i = 0; i < ciclos.size(); i++) {
                Ciclo c = ciclos.get(i);
                LinkedList<Materia> materias = ciclos.get(i).getMaterias();
                for (int j = 0; j < materias.size(); j++) {
                    Materia materia = materias.get(j);
        %>
        <form class="text-center justify-content-center"  action="../Controladores/controladorProfesor.jsp" method="POST" >

            <div class="card border-dark m-3 ">
                <div class="card-header bg-secondary text-white mb-2">
                    <h3><%= c.getNombre()%></h3>
                </div>
                <div class="card-subtitle">
                    <h3><%= materia.getNombre()%></h3>
                </div>
                <div class="card-body">
                    <input  type="hidden" name="idCiclo" value="<%= c.getId_ciclo()%>">
                    <input  type="hidden" name="idMateria" value="<%= materia.getId()%>">
                    <h6> <%= materia.getDescripcion()%></h6>
                    <h6><%= materia.getEstudiantes().size()%></h6>
                    <input class="btn btn-success" type="submit" name="Entrar" value="Entrar">
                </div>
            </div>
        </form>
        <%}
            }
        %>
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
