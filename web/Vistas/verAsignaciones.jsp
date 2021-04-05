<%-- 
    Document   : verAsignaciones
    Created on : 31-mar-2021, 21:18:57
    Author     : isra9
--%>

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
                            <h3 class="font-weight-bold my-4">Gestión de Materias</h3>
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
                                LinkedList<Ciclo> ciclosAsignados = null;
                                if (session.getAttribute("ciclosAsignados") != null) {
                                    ciclosAsignados = (LinkedList<Ciclo>) session.getAttribute("ciclosAsignados");
                                }
                                LinkedList<Ciclo> ciclos = null;
                                if (session.getAttribute("ciclos") != null) {
                                    ciclos = (LinkedList<Ciclo>) session.getAttribute("ciclos");
                                }
                                LinkedList<Materia> materias = null;
                                Materia materia = new Materia();
                                if (session.getAttribute("materias") != null) {
                                    materias = (LinkedList<Materia>) session.getAttribute("materias");
                                }
                                if (session.getAttribute("Materia") != null) {
                                    materia = (Materia) session.getAttribute("Materia");
                                }
                            %>

                            <h3><%=materia.getNombre()%></h3>
                            <h6><%=materia.getDescripcion()%></h6>
                            <form class="text-center mx-auto row"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                <input type="hidden" name="idMateria" value="<%= materia.getId()%>">
                                <select name="cicloAsignado" class="from-control col-2 m-1">
                                    <% for (int i = 0; i < ciclos.size(); i++) {
                                            Ciclo c = ciclos.get(i);%>
                                    <option value="<%=c.getId_ciclo()%>"><%=c.getNombre()%></option>
                                    <%}%>
                                </select>
                                <input class="btn btn-primary  text-center" type="submit" name="asignarMateria" value="+">
                                <input class="btn btn-primary  text-center" type="submit" name="crudMaterias" value="Crud Materias">
                            </form>
                            <hr>

                            <table class="mx-auto table table-striped" >
                                <tr class="m-5">
                                    <th>id</th>
                                    <th >Nombre</th>
                                    <th >Descripcion</th>
                                    <th >Acciones</th>
                                </tr>
                                <%
                                    for (int i = 0; i < ciclosAsignados.size(); i++) {
                                        Ciclo c = ciclosAsignados.get(i);
                                %>
                                <form class="text-center justify-content-center"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                    <input type="hidden" name="idMateria" value="<%= materia.getId()%>">
                                    <tr>
                                    <input type="hidden" name="id" value="<%= c.getId_ciclo()%>">
                                    <td >
                                        <p><%=c.getId_ciclo()%></p>
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="nombre" value="<%=c.getNombre()%>" readonly>
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="descripcion" value="<%=c.getDescripcion()%>" readonly>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-danger m-1 p-1" type="submit" name="eliminarAsignacion" title="eliminar Asignacion">-</button>
                                    </td>
                                    </tr>
                                </form>
                                <%}%>
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
