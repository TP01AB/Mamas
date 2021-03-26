<%-- 
    Document   : controladorAdmin
    Created on : 21-mar-2021, 1:57:20
    Author     : isra9
--%>

<%
    //Borramos el mensaje para que tras el cambio de pagina no muestre  el mismo mensaje.
    if (session.getAttribute("mensaje") != null) {
        session.setAttribute("mensaje", null);
    }
    //HOME
    if (request.getParameter("adminHome") != null) {
        response.sendRedirect("../Vistas/inicioAdmin.jsp");
    }
    //CRUD USUARIOS
    if (request.getParameter("crudUsuarios") != null) {
        response.sendRedirect("../Vistas/Administrador/crudUsuarios.jsp");
    }
    //CRUD MATERIAS
    if (request.getParameter("crudMaterias") != null) {
        response.sendRedirect("../Vistas/Administrador/crudMaterias.jsp");
    }
    //CRUD CICLOS
    if (request.getParameter("crudCiclos") != null) {
        response.sendRedirect("../Vistas/Administrador/crudCiclos.jsp");
    }
    //CERRAR SESION
    if (request.getParameter("close") != null) {
        session.removeAttribute("usuarioActual");
        session.removeAttribute("rolActual");
        response.sendRedirect("../index.jsp");
    }
%>