<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.digi.model.*"%>

<%
	String email=(String)session.getAttribute("email");
	String name=(String)session.getAttribute("name");
	if(name==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect("index.jsp"); 
	}else{
		//HttpSession session2=request.getSession();
		//session.setAttribute("name2",name);
		//session.setAttribute("email2",email);
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
<!--link of google font 2-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
<link rel="stylesheet" href="userStyle.css">
<body>
	<div class="nav_main_container">
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
                    <li class="align_item"><a href="User.jsp">Home</a></li>
                    <li class="align_item"><a href="OrderList.jsp">Orders</a></li>
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
               	<p class="name"><%= name %></p>
            	<button style="border:none" onclick="rightPopUp()"><img class="up_arrow align_item" id="arrow" src="chevron-up.svg"></button> 
           </div>       
        </nav>
    </div>
    </div>
    
    <!-- pop Up Menu 1 -->
    <div class="popUpMenu  floatLeft align_item" id="pop1">
        <ul>
            <li class="align_item"><a href="User.jsp">Home</a></li>
            <li class="align_item"><a href="#">Order</a></li>
            <li class="align_item admin2"><a class="" href="#">Admin</a></li>
        </ul>
    </div>
    
    <!-- pop Up Menu 2 -->
    <div class="popUpMenu floatRight align_item" id="pop2">
        <ul>
            <li class="email align_item"><%= email %></li>
            <li class="name align_item">
	            <%
	            DAO db1=new DAO();
	            int count=db1.itemCount(email);
	            db1.closeConnection();
	            %>
	            <span>[<%=count %>]</span>&nbsp;
	            <a href="Cart.jsp">Cart</a>
            </li>
            <li class="align_item"><a class="logoutBtn align_item" href="Logout">Logout</a></li>
        </ul>
    </div>
    
    <!--Admin Login Page Login Entry Page-->
    <div class="login_Page Admin_Login ">
        <form action="AdminLogin" method="post">
            <h2 class="text1">Admin Login</h2>
            <div class="input_field align_item"><input type="text" name="id" placeholder="User Name"></div>
            <div class="input_field align_item"><input type="password" name="password" placeholder="Password"></div>
            <!--<div class="check_field text1">  
            <label>Remember Me:-&nbsp;</label>
            <input type="checkbox">
            </div> -->
            <button type="submit">Login</button>
        </form>
    </div>
  	
<!-- ////////////////////////////////////////Image Slider/////////////////////////////////////////////////////////////////////////////// -->	
	  	 <!-- <div class="slider-container">-->
	  	<div class="slider">
	        <div class="slides">
	            <div class="slide color1"></div>
	            <div class="slide color2"></div>
	            <div class="slide color3"></div>
	            <div class="slide color4"></div>
	        </div>
    	</div>
          
	<!-- ////////////////////////////////////////Categories box/////////////////////////////////////////////////////////////////////////////// -->	
	
	<div class="categoryBox">
		<div class="headText">Categories</div>
		<div class="catImgContainer">
		<%
			DAO db=new DAO();
	        ArrayList<String> categories=(ArrayList<String>)db.getAllCategory();
	       	for(String category:categories){
		%>
			<a class="cateImg"><img src="GetCategoryImg?name=<%= category %>" alt="Error"><p><%= category %></p></a>
		<%} %>
		</div>
	</div>
	
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->	

<!-- /*//////////////////////////////////////////Most Selling Item///////////////////////////////////////////////////////*/ -->
	
	   <div class="itemBoxContainer">
            <div class="itemContainer">
                <h3>Most Selling Product</h3>
                <div class="Box">
                <%
                ArrayList<String> msproducts=(ArrayList<String>)db.getMSProduct();
                int i=0;
                for(String msproduct:msproducts){
                	if(i<4){
                %>
                    <div class="itemBox">
                        <div class="itemImg">
                            <a href="DisplayItem.jsp?name=<%= msproduct %>"><img src="GetProductImage?name=<%= msproduct %>" alt="Error"></a>
                        </div>
                        <div class="itemName"><%= msproduct %></div>
                    </div>
                <%}else{
            		break;
            		}
				 	i++;	
                 }%>
                </div>
            </div>
			
			<div class="itemContainer">
                <h3>Best Rated Product</h3>
                <div class="Box">
                <%
                ArrayList<String> brproducts=(ArrayList<String>)db.getBRProduct();
                db.closeConnection();
                int j=0;
                for(String brproduct:brproducts){
                	if(j<4){
                %>
                    <div class="itemBox">
                        <div class="itemImg">
                            <a href="DisplayItem.jsp?name=<%= brproduct %>"><img src="GetProductImage?name=<%= brproduct %>" alt="Error"></a>
                        </div>
                        <div class="itemName"><%= brproduct %></div>
                    </div>
                <%}else{
            		break;
            		}
				 	i++;	
                 }%>
                </div>
            </div>
            
        </div>

<!-- /////////////////////////////////////Footer Section////////////////////////////////////////////////////////////////////////////////// -->	         
	
	<footer class="footer">
        <div class="footer-container">
            <div class="footer-column">
                <h3>About Us</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
            	<div class="get_in_touch_container align_item">
	      			 <p>Get In Touch</p>
	    		</div>
            </div>
            <div class="footer-column">
                <h3>Helpful Links</h3>
                <ul>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Follow Us</h3>
                <ul>
                    <li><a href="#">Facebook</a></li>
                    <li><a href="#">Twitter</a></li>
                    <li><a href="#">Instagram</a></li>
                </ul>
            </div>
        </div>
    </footer>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->	

</body>
<script type="text/javascript" src="UserJS.js"></script>
</html>
<%
	}
%>