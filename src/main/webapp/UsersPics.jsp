<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.models.User"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.servlets.Profile"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="/Instagrim/Styles.css" />
    </head>
    <body>
        <header>

            <h1>InstaGrim ! </h1>
            <h2>Your world in Black and White</h2>
        </header>       
        <ul>
            <li><a href="/Instagrim">Home</a></li>
            <li><a href="/Instagrim/upload.jsp">Upload</a></li>                
            <li><a href="/Instagrim/profile.jsp">Profile</a></li>
        </ul>
        <article>
            <h1>Your Pics</h1>
            <%
                java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
                if (lsPics == null) {
            %>
            <p>No Pictures found</p>
            <%
            } else {
                Iterator<Pic> iterator;
                iterator = lsPics.iterator();
                while (iterator.hasNext()) {
                    Pic p = (Pic) iterator.next();

            %>
            <a href="/Instagrim/Image/<%=p.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=p.getSUUID()%>"></a>

            <form method="POST"  action="Instagrim/Profile">  
                <input type="text" name="picid" value="<%=p.getSUUID()%>" >                 
                <input type="submit" value="Make profile pic">
            </form>
            <%
                    }
                }
            %>            
        </article>        
    </body>
</html>
