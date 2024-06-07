<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

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
<title>Insert title here</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Protest+Revolution&family=Protest+Strike&display=swap" rel="stylesheet">
<link rel="stylesheet" href="AdminHome.css">
<body>
	<header class="msg text1">
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
                    <input type="text" name="p_name" placeholder="Search Product">
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
            <li class="logoutBtn align_item"><a class="" href="Logout">Logout</a></li>
        </ul>
    </div>
    
    <div class="uu"></div>

</body>
<script type="text/javascript" src="AdminJS.js"></script>
</html>
<%
	}
%>