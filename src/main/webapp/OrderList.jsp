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
<link rel="stylesheet" href="OrderListStyle.css">
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
                    <li class="align_item"><a href="#Admin">Orders</a></li>
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
            <li class="email align_item"><%=email %></li>
            <li class="align_item"><a class="logoutBtn align_item" href="Logout">Logout</a></li>
        </ul>
    </div>
<!-- End Of Navigation Bar  -->

<!-- Order List Of User -->
	<div class="heading"><p>All Order</p></div>
    <div class="orderlist">
        <!-- Parametre Container -->
        <div class="parametersContainer">
            <div class="parameter" style="width:10%;">OrderId</div>
            <div class="parameter" style="width:50%;">Product</div>
            <div class="parameter" style="width:10%">Date</div>
            <div class="parameter" style="width:10%">Price</div>
            <div class="parameter" style="width:20%;">Status</div>
        </div>
        <!-- About Product OrderList -->  
            <%
            DAO db=new DAO();
            ArrayList<HashMap<String,Object>> orders=(ArrayList<HashMap<String,Object>>)db.getorderInfoByEmail(email);
            db.closeConnection();
            for(HashMap<String,Object> order:orders){
            	String id = (String)order.get("id");
            	String address = (String)order.get("address");
            	int total = (int)order.get("total");
            	String order_date = (String)order.get("order_date");
            	String order_item = (String)order.get("order_item");
            	String status = (String)order.get("status");
            	String names_prices[] = order_item.split(",");
            	String NameArray[] = new String[names_prices.length];
        		String PriceArray[] = new String[names_prices.length];
            for(String name_price : names_prices){
            	String Split_N_P[]= name_price.split(":-");
            	int j=0;
            	for(int i=0;i<Split_N_P.length;i=i+2){
            		NameArray[j] = Split_N_P[i];
            		PriceArray[j] = Split_N_P[i+1];
            		j++;
            	}
     
            	for(int i=0;i<Split_N_P.length;i=i+2){
            		%>
           <div class="itemBox"> 		
            <div class="orderId"><%= id %></div>
            <div class="product">
                <div class="productImg"><img src="GetProductImage?name=<%= NameArray[i] %>" alt="error"></div>
                <div class="textBox">
                    <p style="font-size: 18px;font-weight: 500;"><%= NameArray[i] %></p>
                    <p style="color: rgb(145, 145, 145);"><%= address %></p>
                </div>
            </div>
            <div class="date">
                <%= order_date %>
            </div>
            <div class="price">
                <%= PriceArray[i] %>
            </div>
            <div class="status">
                <div class="statusbtn" id="btn1">
                <%
                if(status.equalsIgnoreCase("pending")||status.equalsIgnoreCase("success")){
                %>
                <p id="statusText"><%= status %></p>
                <%}else{%>
                    <p style="background-color: rgb(253, 84, 84);" id="statusText"><%= status %></p>
                <%} %>    
                </div>
                <%
                if(status.equalsIgnoreCase("pending")||status.equalsIgnoreCase("success")){
                %>
                <a href="ChangrOrderStatus?<%= id %>&email=<%= email %>&status=canceled&page=OrderList">Cancel</a>
                <%}%>
            </div>
           </div>
            	<%}%>
            <%}}%>
    </div>
	
</body>
<script type="text/javascript" src="CartJS.js"></script>
</html>
<%
	}
%>