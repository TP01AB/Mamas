<%-- 
    Document   : controladorProfesor
    Created on : 21-mar-2021, 1:57:04
    Author     : isra9
--%>

<%
    //Borramos el mensaje para que tras el cambio de pagina no muestre  el mismo mensaje.
    if (session.getAttribute("mensaje") != null) {
        session.setAttribute("mensaje", null);
    }
    //HOME
    if (request.getParameter("profHome") != null) {
        response.sendRedirect("../Vistas/inicioProf.jsp");
    }
    //CERRAR SESION
    if (request.getParameter("close") != null) {
        session.removeAttribute("usuarioActual");
        session.removeAttribute("rolActual");
        response.sendRedirect("../index.jsp");
    }
%>