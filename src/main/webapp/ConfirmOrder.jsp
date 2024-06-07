<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.digi.model.DAO"%>

<%
	String name=(String)session.getAttribute("name");
	String email=(String)session.getAttribute("email");
	if(name==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect("index.jsp");
	}else{%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Digi_Shop</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Protest+Revolution&family=Protest+Strike&display=swap" rel="stylesheet">
<link rel="stylesheet" href="ConfirmOrderStyle.css">
<body>
	<div class="nav_main_container">
	<header class="msg align_item text1">
		<!-- Warning messages -->
		<% 
			String msg=(String)session.getAttribute("msg");
		 	if(msg!=null){
		%>
				<p><%= msg %></p>
		<%	
				session.setAttribute("msg", null);
		 	}
		%>
	</header>
	<!-- navigation bar -->
	<div>
        <nav class="nav_Container text1">
            <!--Main Logo-->
            <div class="main_logo"><img src="logo.png" alt="Logo"></div>
            
            <!--navigation list-->
            <div class="nav_list_container">
                    <div class="ham_burger" id="burger">
                        <div class="layer"></div>
                        <div class="layer"></div>
                        <div class="layer"></div>
                    </div>
                <ul class="nav_list ">
                    <!-- <li class="align_item"><a href="AdminHome.jsp">Home</a></li>
                    <li class="align_item"><a href="#Admin">Orders</a></li>
                    <li class="align_item"><a href="#">Contact</a></li> -->
                </ul>
            </div>
            <!--Search box-->
    		<div class="search_container align_item">
                 
            </div>
            <!--User Profile-->
            <div class="User_Container align_item">
               	<img class="avatar" src="ghost.svg">
               	<p class="name"><%= name %></p>
            	<button style="border:none" onclick="rightPopUp()"><img class="up_arrow align_item" id="arrow" src="chevron-up.svg"></button> 
           </div>       
        </nav>
    </div>
    </div>
    
   <!-- pop Up Menu 1 -->
    <div class="popUpMenu  floatLeft align_item" id="pop1">
        <ul>
            <li class="align_item"><a href="index.jsp">Home</a></li>
            <li class="align_item"><a href="#Admin">Orders</a></li>
            <li class="align_item"><a href="#">Contact</a></li>
        </ul>
    </div>
    
    <!-- pop Up Menu 2 -->
    <div class="popUpMenu floatRight align_item" id="pop2">
        <ul>
            <li class="email align_item"><%=email %></li>
            <li class="align_item"><a class="logoutBtn align_item" href="Logout">Logout</a></li>
        </ul>
    </div>

	<!--/////////////////////////////////// Order Place ///////////////////////////////////////////-->
	<div class="box">
        <div class="btnContainer">
            <div >sdcskjhck</div>
            <div><a href="">Confirm Order</a></div>
        </div>
    </div>
	
</body>
</html>
<%
	}
%>