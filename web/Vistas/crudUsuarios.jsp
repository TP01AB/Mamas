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

        <div class="container-fluid d-flex justify-content-center">
            <div class="row principal rounded">
                <jsp:include page="../Recursos/navbar.jsp"/>
                <!-- Título de la sección -->
                <div class="col-12 mt-4 ml-4">
                    <h4 class="h4">Crud administrador: Usuarios</h4>
                </div>

                <!-- Cuerpo -->
                <div class="col-12 mt-4 px-4 d-flex justify-content-center">
                    <table class="table table-hover w-75" style="text-align: center">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Correo</th>
                                <th scope="col">Contraseña</th>
                                <th scope="col">Rol</th>
                                <th scope="col">Activo</th>
                                <th scope="col">Intentos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (session.getAttribute("usuarios") != null) {
                                    LinkedList usuarios = (LinkedList) session.getAttribute("usuarios");
                                    for (int i = 0; i < usuarios.size(); i++) {
                                        Usuario u = (Usuario) usuarios.get(i);
                            %>
                            <tr>
                        <form name="crudUsuario" action="../Controladores/controladorAdmin.jsp" method="POST">
                            <th scope="row"><%=u.getId_user()%></th>
                            <input type="hidden" name="id" value="<%=u.getId_user()%>">
                            <td><input class="form-control" type="email" name="email" value="<%=u.getEmail()%>"></td>
                            <td><input class="form-control" type="password" name="password" value="<%=u.getPassword()%>"></td>
                            <td><input type="number" name="rol" value="<%=u.getRol()%>"></td>
                            
                            <td><input type="submit" class="btn btn-success" name="actualizarUsuario" value="Guardar"></td>
                            <td><input type="submit" class="btn btn-danger" name="eliminarUsuario" value="Eliminar"></td>
                        </form>
                        </tr>
                        <%                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
                <jsp:include page="recursos/footer.jsp"/>
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
