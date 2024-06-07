<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.digi.model.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DigiShop</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Protest+Revolution&family=Protest+Strike&display=swap" rel="stylesheet">
<!--link of google font 2-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
<link rel="stylesheet" href="DisplayItemStyle.css">
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
                <%  String name=(String)session.getAttribute("name");
               		String email=(String)session.getAttribute("email");
               		if(name==null && email==null){
                %>
                	<p class=""></p>
                <%}else{%>
                	<p class="name text1"><%= name %></p>
                <%} %>
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
  	
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->	

<!-- /*//////////////////////////////////////////Item Display///////////////////////////////////////////////////////*/ -->
	<%
	String itemName = request.getParameter("name");
	%>
	<div class="ProductDisplay">
    <div class="topHeading"></div>
    <div class="productBox">
        <div class="leftSide">
            <div class="ProductImg"><img src="GetCategoryImg?name=<%= itemName %>"  alt="error"></div>
        </div>
        <div class="rightSide">
            <div class="aboutItem">
                <div>
                    <p style="padding-top: 20px; padding-left: 5px; font-size:12px; font-weight: 600; color:rgb(131, 130, 130);">Name:-</p>
                    <p style="padding: 10px;">jbfbsdcbk</p>
                </div>
                <div>
                    <p style="padding-top: 20px; padding-left: 5px; font-size:12px; font-weight: 600; color:rgb(131, 130, 130);">Name:-</p>
                    <p style="padding: 10px;">jbfbsdcbk</p>
                </div>
                <div>
                    <p style="padding-top: 20px; padding-left: 5px; font-size:12px; font-weight: 600; color:rgb(131, 130, 130);">Name:-</p>
                    <p style="padding: 10px;">jbfbsdcbk</p>
                </div>
                <section class="Description">
                    <p style="padding-top: 20px; padding-left: 5px; font-size:12px; font-weight: 600; color:rgb(131, 130, 130);">Info</p>
                    <p style="padding: 10px;">Lorem ipsum dolor sit amet 
                        consectetur adipisicing elit.
                         Vel, porro ut? Sint, sequi 
                         veritatis sunt placeat aperiam
                          suscipit ut doloremque!
                    </p>
                </section>
            </div>
        </div>
    </div>
   </div>
   <div class="BtnSection">
        <div><a id="buyBtn" href="">Buy Now</a></div>
        <div><a id="AddToCartBtn" href="">Add To Cart</a></div>
   </div>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->	
	
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
