<%-- 
    Document   : crudConvalidacion
    Created on : 03-abr-2021, 16:35:41
    Author     : isra9
--%>

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
                                LinkedList<Ciclo> ciclos = (LinkedList<Ciclo>) session.getAttribute("ciclosCompletos");
                                LinkedList<Profesor> profesores = (LinkedList<Profesor>) session.getAttribute("profesores");

                                Ciclo c;
                                c = (Ciclo) session.getAttribute("Ciclo");
                            %>

                            <h3><%=c.getNombre()%></h3>
                            <h6><%=c.getDescripcion()%></h6>
                            <form class="text-center mx-auto row"  action="../Controladores/controladorAdmin.jsp" method="POST" >

                                <input class="btn btn-primary  text-center" type="submit" name="crudMaterias" value="Crud Materias">
                            </form>
                            <hr>

                            <table class="mx-auto table table-striped" >
                                <tr class="m-5">
                                    <th>id</th>
                                    <th >Nombre</th>
                                    <th >Descripcion</th>
                                    <th>Profesor</th>
                                    <th >Acciones</th>
                                </tr>
                                <%
                                    for (int i = 0; i < ciclos.size(); i++) {
                                        if (ciclos.get(i).getId_ciclo() == c.getId_ciclo()) {
                                            LinkedList<Materia> materias = ciclos.get(i).getMaterias();
                                            for (int j = 0; j < materias.size(); j++) {
                                                Materia materia = materias.get(j);

                                %>
                                <form class="text-center justify-content-center"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                    <input type="hidden" name="idMateria" value="<%= materia.getId()%>">
                                    <tr>
                                    <input type="hidden" name="id" value="<%= materia.getId()%>">
                                    <td >
                                        <p><%=materia.getId()%></p>
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="nombre" value="<%=materia.getNombre()%>" readonly>
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="descripcion" value="<%=materia.getDescripcion()%>" readonly>
                                    </td>

                                    <td>
                                        <select>
                                            <% for (int k = 0; k < profesores.size(); k++) {
                                                    Profesor p = profesores.get(k);
                                            %>
                                            <option value="<%=p.getId_user()%>"><%=p.getNombre()%></option>
                                            <%}%>
                                        </select>
                                    </td> 
                                    <td class="text-center">
                                        <button class="btn btn-danger m-1 p-1" type="submit" name="eliminarAsignacion" title="eliminar Asignacion">-</button>
                                    </td>
                                    </tr>
                                </form>
                                <%}
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