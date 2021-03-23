<%-- 
    Document   : navbar
    Created on : 21-mar-2021, 1:37:52
    Author     : isra9
--%>
<%@page import="Modelo.Usuario"%>
<div>

    <% int rol = (int) session.getAttribute("rolActual");
%>
    <%
        if (rol == 3) {
    %>
    <form action="../Controladores/controladorAdmin.jsp" method="POST">    
        <button type="submit" name="adminHome">Home</button>
    </form>
    <%
        }
    %>
    <%
        if (rol == 3) {
    %>
    <form action="../Controladores/controladorAlu.jsp" method="POST">    
        <button type="submit" name="adminAlu">Home</button>
    </form>
    <%
        }
    %>
    <%
        if (rol == 3) {
    %>
    <form action="../Controladores/controladorProf.jsp" method="POST">    
        <button type="submit" name="profHome">Home</button>
    </form>
    <%
        }
    %>
</div>