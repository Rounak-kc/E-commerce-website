<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.digi.model.DAO"%>

<% String adminName=(String)session.getAttribute("adminName");
	if(adminName==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect("index.jsp");
	}else{%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Protest+Revolution&family=Protest+Strike&display=swap" rel="stylesheet">
<link rel="stylesheet" href="MSProductStyle.css">
<meta charset="ISO-8859-1">
<title>DigiShop</title>
</head>
<body>
	<div class="nav_main_container">
	<header class="msg align_item text1">
	<!-- Message -->
	<%
		String msg=(String)session.getAttribute("msg");
		if(msg!=null){
	%>
		
			<p><%= msg %></p>
		
	<%
		session.setAttribute("msg",null);
		}
	%>
	</header>
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
                    <li class="align_item"><a href="index.jsp">Home</a></li>
                    <li class="align_item"><a href="#Enquiry">Enquiry</a></li>
                    <li class="align_item"><a href="#product">Product</a></li>
                    <li class="align_item"><a href="#Contact">Contact</a></li>
                    <li class="align_item admin"><a href="#Admin">Admin</a></li>
                </ul>
            </div>
            <!--Search box-->
            <div class="search_container align_item">
                <form class="search_box align_item" action="UserProduct.jsp" method="post">
                    <input type="text" name="p_name" placeholder="Search Product">
                    <button class="align_item" type="submit"><img src="search.svg"></button>
                </form> 
            </div>   
    
            <!--SignIn & signUp-->
            <div class="User_Container align_item">
                <img class="avatar" src="ghost.svg">
                <p class="name text1"><%= adminName %></p>
                <button style="border:none" onclick="rightPopUp()"><img class="up_arrow align_item" id="arrow" src="chevron-up.svg"></button>
            </div>      
        </nav>
    </div>
    </div>
    
    
    
<!-- //////////////////////////////////////////pop Up Menu///////////////////////////////////////////////////////////////////////////// -->
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
            <li class="email align_item name"><%= adminName %></li>
            <li class="align_item"><a class="logoutBtn align_item" href="Logout">Logout</a></li>
        </ul>
    </div>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
      
    <!-- Product Box -->
    	<%
    		String servletname = request.getParameter("servletname");
    		String search = request.getParameter("pname");
			DAO db=new DAO();
			ArrayList<HashMap<String,Object>> products=(ArrayList<HashMap<String,Object>>)db.getProductLikeName(search);
			db.closeConnection();
         %>
         	<div class="productAllDisplay">
         		<div class="asideDisplay"></div>
         		<div class="productDisplay">
         <%
			for(HashMap<String,Object> product:products){
		%>
				<section class="productContainer">
	                <ul class="topItem">
	                    <li class="productImage"><img alt="Error" src="GetProductImage?name=<%=product.get("name") %>"/></li>
	                    <li class="productList productName"><%= product.get("name") %></li>
	                </ul>
	                <ul>
	                    <li class="productList ">
	                    <form class="FormContain" action="<%= servletname %>" method="post">
	                    	<input type="hidden" name="name" value="<%= product.get("name") %>">
	                    	<button class="CartBtn" type="submit" ><img src="trolley-cart-ui-2-svgrepo-com.svg"></button>
	                    </form>
                    	</li>
	                </ul>
	            </section>
	        
		<%
			}
		%>
				</div>
			</div>
	
    
	
</body>
<script type="text/javascript" src="MSProductScript.js"></script>
</html>
<%}%>