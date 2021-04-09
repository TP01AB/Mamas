<%-- 
    Document   : navbar
    Created on : 21-mar-2021, 1:37:52
    Author     : isra9
--%>
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<!-- Material Design Bootstrap -->
<link rel="stylesheet" href="../css/mdb.min.css">
<!-- Your custom styles (optional) -->
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/all.css">
<!-- SCRIPT -->

<!-- jQuery -->
<script type="text/javascript" src="../js/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="../js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="../js/mdb.min.js"></script>
<div class="pl-4  row bg-primary mb-3">
    <h4 class=" display-4 font-weight-bold white-text ">Mamás 2.0</h4>
    <% int rol = (int) session.getAttribute("rolActual");

        if (rol == 3) {
    %>
    <div class=" row">

        <form action="../Controladores/controladorAdmin.jsp" method="POST">    
            <button class="btn btn-secondary" type="submit" name="adminHome">Home</button>
            <button class="btn btn-secondary" type="submit" name="profHome" >Home prof</button>
            <%
            } else
            %>
            <%if (rol == 1) {
            %>
            <form action="../Controladores/controladorAlumno.jsp" method="POST">    
                <button class="btn btn-secondary" type="submit" name="aluHome">Home</button>

                <%
                } else
                %>
                <%if (rol == 2) {
                %>
                <form action="../Controladores/controladorProfesor.jsp" method="POST">    
                    <button class="btn btn-secondary" type="submit" name="profHome">Home</button>

                    <%
                        }
                    %>
                    <button class="btn btn-secondary" type="submit" name="editarPerfil" >Editar perfil</button>
                    <button class="btn btn-secondary" type="submit" name="close">Cerrar sesion</button>
                    </div>
                </form>
                </div>