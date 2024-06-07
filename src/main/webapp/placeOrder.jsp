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
<!--link of google font 1-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Protest+Revolution&family=Protest+Strike&display=swap" rel="stylesheet">
<!--link of google font 2-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">

<link rel="stylesheet" href="PlaceOrderStyle.css">
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
            <li class="email align_item"><%= email %></li>
            <li class="align_item"><a class="logoutBtn align_item" href="Logout">Logout</a></li>
        </ul>
    </div>

	<!--/////////////////////////////////// Order Place ///////////////////////////////////////////-->
	<div class="mainContainer">
  <h2>Order</h2>
  <div class="orderBox">
  <!-- Left body of Main Container -->
    <div class="leftPart">
      <h1>Name</h1>
      <p class="category"><a href="">information</a>/<a href="" style="color: rgb(7, 165, 165);">Payment</a></p>
      <!-- USer Information -->
      <div class="userInfo">
        <!-- Contact Information -->
        <div class="subinfo">
          <div class="sub">
            <span>Contact</span>
            <p><%= email %></p>  
          </div>
          <div class="changebtn">
            <button type="submit" onclick="addressDropDown()">change</button>  
          </div>
        </div>
        <hr/>
        <!-- Address Information -->
        <div class="subinfo">
          <div class="sub">
            <span>Address</span>
            <%
        	DAO db=new DAO();
            String currentaddress=db.getCurrentAddress(email);
            %>
            <p><%= currentaddress %></p>
            <div class="addressInput">
              <div>
              <form class="AddressForm" action="AddAddress" method="post">
                <input type="text" name="address" placeholder="Address">
                <button type="submit" onclick="closepopAddressForm()">Add</button>
              </form>
            </div>
              <button class="NewAddressBtn" type="submit" onclick="popAddressForm()">Add New Address</button>
            </div>   <!-- Address Field -->
            
          </div>
          <div class="changebtn" id="changebtn2">
            <button type="submit" onclick="addressDropDown()">change</button>
          </div>
        </div>
      </div>
      <div class="selectSection" id="select">
        <!-- List For Address -->
        <form class="selectform" action="Currentaddress" method="post">
        	<%
        	ArrayList<String> addresses=(ArrayList<String>)db.getAddressByEmail(email);
        	db.closeConnection();
        	for(String address:addresses){
        	%>
          <div><input type="radio" name="address" value="<%= address %>">&nbsp;&nbsp;&nbsp;&nbsp;<p><%= address %></p></div>
          <%} %>
          <button type="submit">change</button>
        </form>
      </div>
      <!-- Payment Type section-->
      <div class="PaymentContainer">
        <div class="paymentHead">
          <div class="payText">
            <p style="font-size: 30px;font-weight: bold;">Payment</p>
            <p style="margin: 5px;color: rgb(151, 151, 151);">All transaction are secure and encrypted</p>
          </div>
          <div class="payType">
            <img src="plus.png">
          </div>
        </div>
        <!-- Drop Down For Payment method -->
        <div class="paylistbox">
          <ul class="target">
            <li class="list"><a href=""><img src="phonepe.png"></a></li>
            <li class="list"><a href=""><img src="paytm.png"></a></li>
            <li class="list"><a href=""><img src="googlepay.png"></a></li>
            <li class="list"><a href=""><img src="applepay.png"></a></li>
            <li class="list"><a href=""><img style="width: 50px;" src="plus.png"></a></li>
          </ul>
        </div>
      </div>
      <!-- Bottom section Contain Place Order button -->
      <div class="bottomsection">
        <div class="bottomleft">

        </div>
        <div class="bottomright">
        	<a href="AddOrderInfo?crtAddress=<%= currentaddress %>">Complete Order</a>
        </div>
      </div>
    </div>
    
    <!-- Right body of the Main Container -->
  	<%
  	int subtotal=(int)session.getAttribute("total");
  	int Shipping_fee=40;
  	%>
    <div class="rightPart">
      <ul class="orderlist">
        <li class="amountlist">
          <p style="font-size:15px; font-weight:600;">Sub-total</p>
          <p>Rs<%= subtotal %>/-</p>
        </li>
        <li class="amountlist">
          <p style="font-size:15px; font-weight:600;">Shipping-fee</p>
          <p>Rs<%= Shipping_fee %>/-</p>
        </li>
        <hr/>
        <li class="amountlist">
          <p style="font-size:15px; font-weight:600;">Total</p>
          <p>Rs<%= subtotal+Shipping_fee %>/-</p>
        </li>
        <hr/>
        
        <!--Product list for ordered item  -->
        <li class="productlist">
          <a>
            <img src="" alt="error">
            <span>
              <p style="text-align: center;">ljjkjkjkjl</p>
              <p style="color:rgb(148, 148, 148);text-align: center;">quantity</p>
            </span>
          </a>
        </li>
        <hr/>
 
      </ul>
    </div>
  </div>
 </div>
	
</body>
<script type="text/javascript" src="OrderScript.js"></script>
<script type="text/javascript" src="OrderScript2.js"></script>
</html>
<%
	}
%>