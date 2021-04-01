<%-- 
    Document   : crudMaterias
    Created on : 23-mar-2021, 23:07:35
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
                                LinkedList<Ciclo> ciclos = null;
                                if (session.getAttribute("ciclos") != null) {
                                    ciclos = (LinkedList<Ciclo>) session.getAttribute("ciclos");
                                }
                                LinkedList<Materia> materias = null;
                                if (session.getAttribute("materias") != null) {
                                    materias = (LinkedList<Materia>) session.getAttribute("materias");
                                }
                            %>
                            <form class="text-center row"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                <input class="form-control col-3 m-1" type="text" name="nombre" placeholder="introduce un nombre" >
                                <input class="form-control col-5 m-1" type="text" name="descripcion" placeholder="introduce una descripcion" >
                                <select name="cicloAsignado" class="from-control col-2 m-1">
                                    <option value="-1">Ninguna</option>
                                    <% for (int i = 0; i < ciclos.size(); i++) {
                                            Ciclo c = ciclos.get(i);%>
                                    <option value="<%=c.getId_ciclo()%>"><%=c.getNombre()%></option>
                                    <%}%>
                                </select>
                                <input class="btn btn-primary col-2 text-center" type="submit" name="addMateria" value="+">

                            </form>
                            <hr>
                            <table class="table table-striped mx-auto" >
                                <tr class="m-5">
                                    <th scope="col">id</th>
                                    <th scope="col" >Nombre</th>
                                    <th scope="col" >Descripcion</th>
                                    <th scope="col" >Acciones</th>
                                </tr>
                                <%
                                    for (int i = 0; i < materias.size(); i++) {
                                        Materia m = materias.get(i);
                                %>
                                <form class="text-center justify-content-center"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                    <tr >
                                    <input type="hidden" name="id" value="<%= m.getId()%>">
                                    <td scope="row" >
                                        <%=m.getId()%>
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="nombre" value="<%=m.getNombre()%>" >
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="descripcion" value="<%=m.getDescripcion()%>" >
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-success m-1 p-1" type="submit" name="verAsignaciones" title="Ver ciclos asignados">Ver</button>
                                        <button class="btn btn-success m-1 p-1" type="submit" name="editarMateria" title="editar Materia">+</button>
                                        <button class="btn btn-danger m-1 p-1" type="submit" name="eliminarMateria" title="eliminar Materia">-</button>
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
