<%-- 
    Document   : crudUsuarios
    Created on : 23-mar-2021, 23:07:13
    Author     : isra9
--%>

<%@page import="Modelo.Usuario"%>
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
                            <h3 class="font-weight-bold my-4">Gestión de usuarios</h3>
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
                                Usuario uActual = (Usuario) session.getAttribute("usuarioActual");
                                LinkedList<Usuario> Usuarios = null;
                                if (session.getAttribute("usuarios") != null) {
                                    Usuarios = (LinkedList<Usuario>) session.getAttribute("usuarios");
                                }
                            %>
                            <table >
                                <tr class="m-5">
                                    <th>DNI</th>
                                    <th >Nombre</th>
                                    <th >Apellidos</th>
                                    <th >E-mail</th>
                                    <th>Telefono</th>
                                    <th >Activado</th>
                                    <th >Rol</th>
                                    <th >Metodos</th>
                                </tr>
                                <%
                                    for (int i = 0; i < Usuarios.size(); i++) {
                                        Usuario u = Usuarios.get(i);
                                        boolean actual = false;
                                        if (u.getId_user() == uActual.getId_user()) {
                                            actual = true;
                                        }
                                %>
                                <form class="text-center"  action="../Controladores/controladorAdmin.jsp" method="POST" >
                                    <tr>
                                    <input type="hidden" name="id" value="<%= u.getId_user()%>">
                                    <td >
                                        <input class="form-control" type="text" name="dni" value="<%=u.getDni()%>" >
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="nombre" value="<%=u.getNombre()%>" >
                                    </td>
                                    <td>
                                        <input class="form-control" type="text" name="apellidos"  value="<%=u.getApellidos()%>">
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="email"  value="<%=u.getEmail()%>" <% if (actual) {
                                                out.print("readonly");
                                            }%> >
                                    </td>
                                    <td >
                                        <input class="form-control" type="text" name="telefono" value="<%=u.getTelefono()%>" >
                                    </td>
                                    <td class="text-center <%if (u.isIsActive()) {
                                            out.print("text-success");
                                        } else {
                                            out.print("text-danger");
                                        } %> " >
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-circle-fill" viewBox="0 0 16 16">
                                        <circle cx="8" cy="8" r="8"/>
                                        </svg>
                                        <input type="hidden" name="activado" value="<% if (u.isIsActive()) {
                                                out.print("Activado");
                                            } else {
                                                out.print("Desactivado");
                                            } %>">
                                    </td>
                                    <td class="w-auto text-center ">
                                        <%if (u.getRol() == 1) {
                                        %>
                                        <svg desc="alumno" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                                        </svg>
                                        <%
                                            }%>
                                        <%if (u.getRol() == 2) {
                                        %>
                                        <svg desc="profesor" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
                                        <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                                        </svg>
                                        <%
                                            }%>
                                        <%if (u.getRol() == 3) {
                                        %>
                                        <svg desc="Administrador" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-award-fill" viewBox="0 0 16 16">
                                        <path d="M8 0l1.669.864 1.858.282.842 1.68 1.337 1.32L13.4 6l.306 1.854-1.337 1.32-.842 1.68-1.858.282L8 12l-1.669-.864-1.858-.282-.842-1.68-1.337-1.32L2.6 6l-.306-1.854 1.337-1.32.842-1.68L6.331.864 8 0z"/>
                                        <path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z"/>
                                        </svg>
                                        <%
                                            }%>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-dark-green m-1 p-1" type="submit" name="newPassword" title="enviar nueva contraseña"  <% if (actual) {
                                                out.print("disabled");
                                            }%>>NewPass</button>
                                        <button class="btn btn-danger m-1 p-1" type="submit" name="delete" title="borrar usuario" <% if (actual) {
                                                out.print("disabled");
                                            }%>>X</button>
                                        <button class="btn btn-primary m-1 p-1" type="submit" name="update" title="actualiza usuario">UP</button>
                                                <button class="btn btn-green m-1 p-1" type="submit" name="activar" title="activar usuario"  <% if (actual) {
                                                        out.print("disabled");
                                                    }%>>On/Off</button>
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
