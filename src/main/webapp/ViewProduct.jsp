<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.digi.model.DAO"%>

<%
	String adminName=(String)session.getAttribute("adminName");
	if(adminName==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect("index.jsp");
	}else{
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DigiShop</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Protest+Revolution&family=Protest+Strike&display=swap" rel="stylesheet">
<link rel="stylesheet" href="viewproductstyle.css">
<body>
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
                    <li class="align_item"><a href="AdminHome.jsp">Home</a></li>
                    <li class="align_item"><a href="Enquiries.jsp">Enquiry</a></li>
                    <li class="align_item"><a href="Product.jsp">Product</a></li>
                    <li class="align_item"><a href="ViewProduct.jsp">View Products</a></li>
                    <li class="align_item"><a href="#Admin">Orders</a></li>
                </ul>
            </div>
            <!--Search box-->
            <div class="search_container align_item">
                <form class="search_box align_item" action="UserProduct.jsp" method="post">
                    <input type="text" name="name" placeholder="Search Product">
                    <button class="align_item" type="submit"><img src="search.svg"></button>
                </form> 
            </div>   
    
            <!--User Profile-->
            <div class="User_Container align_item">
               	<img class="avatar" src="ghost.svg">
               	<p class="name"><%=adminName %></p>
            	<button style="border:none" onclick="rightPopUp()"><img class="up_arrow align_item" id="arrow" src="chevron-up.svg"></button> 
           </div>       
        </nav>
    </div>
    
   <!-- pop Up Menu 1 -->
    <div class="popUpMenu  floatLeft align_item" id="pop1">
        <ul>
            <li class="align_item"><a href="index.jsp">Home</a></li>
            <li class="align_item"><a href="#">Equiry</a></li>
            <li class="align_item"><a href="#">Product</a></li>
            <li class="align_item"><a href="#">Contact</a></li>
            <li class="align_item admin2"><a class="" href="#">Admin</a></li>
        </ul>
    </div>
    
    <!-- pop Up Menu 2 -->
    <div class="popUpMenu floatRight align_item" id="pop2">
        <ul>
            <li class="align_item">email</li>
            <li class="align_item"><a class="logoutBtn align_item" href="Logout">Logout</a></li>
        </ul>
    </div>

	
	<!-- View All Products -->
	<section class="ShowProductContainer">
	<h2 class="align_item"> All Product</h2>
		<%
			DAO db=new DAO();
			ArrayList<HashMap<String,Object>> products=(ArrayList<HashMap<String,Object>>)db.getAllProduct();
			db.closeConnection();
			for(HashMap<String,Object> product:products){
		%>
			<div class="ShowProduct">
				<div class="imgBox">
					<img alt="Error" src="GetProductImage?name=<%=product.get("name") %>" height="100px" />
				</div>
				<div class="imgInfo">
					<div class="infoBox"><span>Name:</span><p><%= product.get("name") %></p></div>
					<div class="infoBox"><span>Price:</span><p><%= product.get("price") %></p></div>
					<div class="infoBox"><span>Company:</span><p><%= product.get("company") %></p></div>
					<div class="infoBox"><span>Category:</span><p><%= product.get("category") %></p></div>
					<div class="infoBox"><span>Info:</span><p class="info"><%= product.get("info") %></p></div>
					<div class="infoBox"><span>Quantity:</span><p><%= product.get("quantity") %></p></div>
					<a href="DeleteProduct?name=<%=product.get("name") %>" class="btn btn-sm btn-danger">Delete</a>
				</div>
				</div>
		<%
			} 
		%>
	</section>
	
</body>
<script type="text/javascript" src="ViewProductJS.js"></script>
</html>
<%
	}
%>