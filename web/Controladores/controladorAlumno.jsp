<%-- 
    Document   : controladorAlumno
    Created on : 21-mar-2021, 1:57:30
    Author     : isra9
--%>

<%
    //Borramos el mensaje para que tras el cambio de pagina no muestre  el mismo mensaje.
    if (session.getAttribute("mensaje") != null) {
        session.setAttribute("mensaje", null);
    }
    //HOME
    if (request.getParameter("aluHome") != null) {
        response.sendRedirect("../Vistas/inicioAlu.jsp");
    }
    //CERRAR SESION
    if (request.getParameter("close") != null) {
        session.removeAttribute("usuarioActual");
        session.removeAttribute("rolActual");
        response.sendRedirect("../index.jsp");
    }
%>