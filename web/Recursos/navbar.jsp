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
<div class="row bg-primary mb-3">

    <% int rol = (int) session.getAttribute("rolActual");
    %>
    <%
        if (rol == 3) {
    %>
    <form action="../Controladores/controladorProfesor" method="POST">
        <button type="submit" name="profHome">Home prof</button>
    </form>
    <form action="../Controladores/controladorAdmin.jsp" method="POST">    
        <button type="submit" name="adminHome">Home</button>

        <%
        } else
        %>
        <%if (rol == 1) {
        %>
        <form action="../Controladores/controladorAlumno.jsp" method="POST">    
            <button type="submit" name="aluHome">Home</button>

            <%
            } else
            %>
            <%if (rol == 2) {
            %>
            <form action="../Controladores/controladorProfesor.jsp" method="POST">    
                <button type="submit" name="profHome">Home</button>

                <%
                    }
                %>
                <button type="submit" name="close">Cerrar sesion</button>
            </form>
            </div>