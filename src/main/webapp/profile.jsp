<%-- 
    Document   : profile
    Created on : 14-Oct-2014, 17:56:31
    Author     : plamendenev
--%>

<%@page import="java.util.*"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
    </head>
    <body>
        <h1>InstaGrim!</h1>
        <%
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            if (lg.getlogedin()) {
        %>
        <ul>
            <li><a href="/Instagrim">Home</a></li>    
            <li><a href="/Instagrim/Images/<%=lg.getUser().getUsername()%>">Images</a></li>
        </ul>
        <h2>Your profile</h2>
        <img src="/Instagrim/Thumb/<%%>">
        <h3>First name: <%=lg.getUser().getName()%></h3>
        <h3>Surname: <%=lg.getUser().getSurname()%></h3>
        <h3>Username: <%=lg.getUser().getUsername()%></h3>
        <h3>Email: <%=lg.getUser().getEmail()%></h3>

        <%} else
                response.sendRedirect("/Instagrim/login.jsp");
        %>

    </body>
</html>