<%-- 
    Document   : crudConvalidacion
    Created on : 03-abr-2021, 16:35:41
    Author     : isra9
--%>

<%@page import="Modelo.Convalidacion"%>
<%@page import="Modelo.Estudiante"%>
<%@page import="Modelo.Profesor"%>
<%@page import="Modelo.Materia"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mamas</title>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <!-- Material Design Bootstrap -->
        <link rel="stylesheet" href="../css/mdb.min.css">
        <!-- Your custom styles (optional) -->
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/all.css">
    </head>
    <body>
        <nav>
            <jsp:include page="../Recursos/navbar.jsp"/>
        </nav>
        <section class="text-center">
            <div class="row">  
                <div class="col-md-12 mx-auto">
                    <div class="card rounded col-12 mx-auto">
                        <div class="card-body">
                            <h3 class="font-weight-bold my-4">Convalidaciones</h3>
                            <!<!-- Mensaje de error guardado en sesion -->
                            <%

                                if (session.getAttribute("mensaje") != null) {
                                    String mensaje = (String) session.getAttribute("mensaje");
                            %>
                            <hr>
                            <div ><span name="mensaje" id="mensaje"><%=mensaje%></span></div>
                            <hr>
                            <%}%>
                            <!------------------TABLA------------------------->
                            <%
                                LinkedList<Estudiante> estudiantes = (LinkedList<Estudiante>) session.getAttribute("estudiantes");
                                LinkedList<Convalidacion> convalidaciones = (LinkedList<Convalidacion>) session.getAttribute("convalidaciones");

                            %>
                            <table class="mx-auto table table-striped" >
                                <tr class="m-5">
                                    <th>Ciclo</th>
                                    <th>Materia</th>
                                    <th>Descripcion</th>
                                    <th>Alumno</th>
                                    <th>Acciones</th>
                                </tr>
                                <% for (int i = 0; i < convalidaciones.size(); i++) {
                                        for (int j = 0; j < estudiantes.size(); j++) {
                                            Estudiante e = estudiantes.get(j);
                                            if (e.getCiclo() != null) {
                                                LinkedList<Materia> materias = e.getCiclo().getMaterias();
                                                for (int k = 0; k < materias.size(); k++) {
                                                    Materia materia = materias.get(k);
                                                    if (materia.getId() == convalidaciones.get(i).getIdMateria() && estudiantes.get(j).getId_user() == convalidaciones.get(i).getIdAlumno()) {

                                %>
                                <form class="text-center justify-content-center"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                    <input type="hidden" name="idMateria" value="<%= materia.getId()%>">
                                    <input type="hidden" name="idAlumno" value="<%= convalidaciones.get(i).getIdAlumno()%>">
                                    <tr>
                                        <td >
                                            <input class="form-control" type="text" name="nombreCiclo" value="<%=estudiantes.get(j).getCiclo().getNombre()%>" readonly>
                                        </td>
                                        <td >
                                            <input class="form-control" type="text" name="nombreMateria" value="<%=materia.getNombre()%>" readonly>
                                        </td>
                                        <td >
                                            <input class="form-control" type="text" name="descripcion" value="<%=materia.getDescripcion()%>" readonly>
                                        </td>
                                        <td>
                                            <input class="form-control" type="text" name="nombreAlumno" value="<%= convalidaciones.get(i).getNombreAlumno()%>" readonly>

                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-success m-1 p-2" type="submit" name="aceptaConvalida" title="aceptar">+</button>
                                            <button class="btn btn-danger m-1 p-2" type="submit" name="denegarConvalida" title="rechazar">-</button>

                                        </td>
                                    </tr>
                                </form>
                                <%}
                                                }
                                            }
                                        }
                                    }%>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <footer>
            <jsp:include page="../Recursos/Footer.jsp"/>
        </footer>


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