<%-- 
    Document   : controladorAdmin
    Created on : 21-mar-2021, 1:57:20
    Author     : isra9
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Conexion"%>
<%@page import="java.util.ArrayList"%>
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
        LinkedList usuarios = Conexion.getUsers();
        session.setAttribute("usuarios", usuarios);
        response.sendRedirect("../Vistas/crudUsuarios.jsp");
    }
    //CRUD MATERIAS
    if (request.getParameter("crudMaterias") != null) {

        response.sendRedirect("../Vistas/crudMaterias.jsp");
    }
    //CRUD CICLOS
    if (request.getParameter("crudCiclos") != null) {
        response.sendRedirect("../Vistas/crudCiclos.jsp");
    }
    //CERRAR SESION
    if (request.getParameter("close") != null) {
        session.removeAttribute("usuarioActual");
        session.removeAttribute("rolActual");
        response.sendRedirect("../index.jsp");
    }
%>