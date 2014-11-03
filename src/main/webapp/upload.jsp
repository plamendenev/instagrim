<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.models.User"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>

    <h1>InstaGrim ! </h1>
    <h2>Your world in Black and White</h2>
    <%
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        if (lg.getlogedin()) {
    %>
    <ul>
        <li><a href="/InstagrimPdd/index.jsp">Home</a></li>
        <li><a href="/InstagrimPdd/profile.jsp">Profile</a></li>
        <li><a href="/InstagrimPdd/Images/<%=lg.getUser().getUsername()%>">Images</a></li>
    </ul>
    <%}%>

    <article>
        <h3>File Upload</h3>
        <form method="POST" enctype="multipart/form-data" action="Image">
            File to upload: <input type="file" name="upfile"><br/>

            <br/>
            <input type="submit" value="Upload">
        </form>
    </article>        
</html>
