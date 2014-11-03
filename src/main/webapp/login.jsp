<%-- 
    Document   : login.jsp
    Created on : Sep 28, 2014, 12:04:14 PM
    Author     : Administrator
--%>

<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />

    </head>
    <body>
        <header>
            <h1>InstaGrim ! </h1>
            <h2>Enter your world in Black and White</h2>
        </header>
        <article>
            <h3>Login</h3>
            <form method="POST"  action="Login">
                <ul>
                    <%
                        if (request.getAttribute("invalidLoginMessage") != null) {
                    %>
                    <font color = "red"><%out.println(request.getAttribute("invalidLoginMessage"));%></font>
                    <%}
                    %>
                    <li>User Name <input type="text" name="username"></li>                       
                    <li>Password <input type="password" name="password"></li>
                </ul>
                <input type="submit" value="Login"> 
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/InstagrimPdd/index.jsp">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
