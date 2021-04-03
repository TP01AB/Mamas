<%-- 
    Document   : crudCiclos
    Created on : 23-mar-2021, 23:07:26
    Author     : isra9
--%>

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
                            <h3 class="font-weight-bold my-4">Gestión de Ciclos</h3>
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
                            %>
                            <hr>
                            <form class="text-center"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                <legend>Nuevo Ciclo</legend>
                                <input class="form-control mb-3" type="text" name="nombre" placeholder="introduce un nombre" >
                                <input class="form-control mb-3" type="text" name="descripcion" placeholder="introduce una descripcion" >
                                <input class="form-control mb-3" type="number" name="plazas" placeholder="introduce las plazas maximas" >
                                <input class="btn btn-primary" type="submit" name="addCiclo" value="+">
                            </form>
                            <hr>
                            <table class="mx-auto table table-striped" >
                                <tr class="m-5">
                                    <th>id</th>
                                    <th >Nombre</th>
                                    <th >Descripcion</th>
                                    <th >Plazas</th>
                                    <th >Acciones</th>
                                </tr>
                                <%
                                    for (int i = 0; i < ciclos.size(); i++) {
                                        Ciclo c = ciclos.get(i);
                                %>
                                <form class="text-center justify-content-center"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                    <tr>
                                    <input type="hidden" name="id" value="<%= c.getId_ciclo()%>">
                                    <td >
                                        <p><%=c.getId_ciclo()%></p>
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="nombre" value="<%=c.getNombre()%>" >
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="descripcion" value="<%=c.getDescripcion()%>" >
                                    </td>
                                    <td >
                                        <input class="form-control" type="number" name="plazas" value="<%=c.getPlazasMaximas()%>" >
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-success m-1 p-1" type="submit" name="editarCiclo" title="editar Ciclo">+</button>
                                        <button class="btn btn-danger m-1 p-1" type="submit" name="eliminarCiclo" title="eliminar Ciclo">-</button>
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
    </body>
</html>
