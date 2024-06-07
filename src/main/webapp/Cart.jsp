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
<!--link of google font 2-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">

<link rel="stylesheet" href="cartStyle.css">
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
                    <li class="align_item"><a href="AdminHome.jsp">Home</a></li>
                    <li class="align_item"><a href="OrderList.jsp">Orders</a></li>
                    <li class="align_item"><a href="#">Contact</a></li>
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

	
	<!-- View All Products -->
	<section class="ShowProductContainer">
	<h2>My Cart</h2>
		<%
			int total=0;
			DAO db=new DAO();
			String items[]=db.getAllCartItemByEmail(email);
			if(items==null){%>
			<div class="cartMsg">
		        <p>Cart is Empty</p>
		        <img src="Trolley.png">
      		</div>
			<%}else{
				for(String item:items){
					int price=db.getItemPrice(item);
					total +=price;
					%>
			<div class="ShowProduct">
        		<div class="ProductBox">
          			<a class="imglink"><img alt="Error" src="GetProductImage?name=<%=item %> " alt="error" /></a>
          			<div>
			            <span><strong>Name:-</strong>&nbsp;&nbsp;<%= item %></span>
			            <span><strong>Price:-</strong>&nbsp;&nbsp;Rs&nbsp;<%= price %>/-</span>
			            <a href="RemoveFromCart?item=<%=item %>" class="removebtn">Remove</a>
          			</div>
        		</div>
      		</div>
		<%
					}

				db.closeConnection();
				}	
		%>
	</section>
	<%
	session.setAttribute("total",total);
	if(total!=0){
	%>
	<div class="cartTotalPrice">
	    <p>Total:-&nbsp;&nbsp;Rs&nbsp;<%= total %>/-</p>
	    <!-- <form action="placeOrder.jsp" method="post">
	    	<button type="submit">Place Order</button> 
	    </form> -->
	    <a href="placeOrder.jsp">Place Order</a>
  	</div>
  	<%} %>
</body>
<script type="text/javascript" src="CartJS.js"></script>
</html>
<%
	}
%>