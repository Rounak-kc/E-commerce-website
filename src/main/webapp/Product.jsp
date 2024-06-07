<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.digi.model.DAO"%>
<%@page import ="java.io.PrintWriter" %>

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
<link rel="stylesheet" href="productStyle.css">
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

	<div id="ElementContainer">
	
		<div class="sideBar">
	       <%
				DAO db=new DAO();
				ArrayList<HashMap<String,Object>> products=(ArrayList<HashMap<String,Object>>)db.getAllProduct();
				for(HashMap<String,Object> product:products){
			%>
				<a class="ShowProduct" href="Product.jsp?name=<%=product.get("name") %>">
						<img alt="Error" src="GetProductImage?name=<%=product.get("name") %>" />
						<p><%= product.get("name") %></p>
				</a>
				<%
					} 
				%>
        </div>
        
        
     <div class="ProductItem">   
	<!-- Categories -->
	<div class="CategoryContainer">
        <div class="CategoryHead2"><h2>Category</h2></div>
        <section class="Category">
            <div class="CategoryHead4"><h4>Add</h4></div>
            <form class="FormField" action="Add_Category" method="post">
                <div class="InputField">
                    <input type="text" name="name" placeholder="Category" title="No initial space or charater !">
                </div>
                <button class="Backgroundcolor1">Add</button>
            </form>
        </section>
        <section class="Category">
            <div class="CategoryHead4"><h4>Delete</h4></div>
            <form class="FormField" action="Delete_Category" method="post">
                <div class="SelectField">
                    <select>
                    	<option style="color:grey">select</option>
                        <%
                        ArrayList<String> categories=(ArrayList<String>)db.getAllCategory();
                        for(String category:categories){
                            %>
                            <option><%= category %></option>
                            <%	
                        }
				        %>
                    </select>
                </div>
                <button class="Backgroundcolor2">Delete</button>
            </form>
        </section>
    </div>
	
	<!-- Form for add product in db -->
	 <div class="AddProductContainer">
        <div class="ProductHead"><h2>Add Product</h2></div>
        <section class="AddProduct">
            <form class="ProductInputContainer" action="Add_Product" method="post" enctype="multipart/form-data">
                <div class="ProductInput">
                    <span>Name:-</span>
                    <div class="inputs">
                        <input class="" type="text" name="p_name" placeholder="Product Name" required />
                    </div>
                </div>
                <div class="ProductInput">
                    <span>Price:-</span>
                    <div class="inputs"><input class="" type="number" name="p_price" min="0" placeholder="Price" required /></div>
                </div>
                <div class="ProductInput">
                    <span>Company:-</span>
                    <div class="inputs"><input class="" type="text" name="p_company" placeholder="Company" required /></div>
                </div>
                <div class="ProductInput">
                    <span>Category:-</span>
                    <div class="inputs">
                        <select name="p_category">
                        	<option style="color:grey">select</option>
                        <%
						for(String category:categories){
					     %>
					 		<option><%= category %></option>
					    <%
						    }
					    %>				
                        </select>
                    </div>
                </div>
                <div class="ProductInput">
                    <span>Image:-</span>
                    <div class="inputs" id="background" >
                        <input class="importImage" type="file" accept=".jpeg,.jpg,.png" name="p_image" required />
                    </div>
                </div>
                <div class="ProductInput">
                    <span>Description:-</span>
                    <div class="inputs">
                        <textarea class="" name="p_info" rows="3" maxlength="1000" placeholder="Description" required /></textarea>
                    </div>
                </div>
                <div class="ProductInput">
                    <span>Quantity:-</span>
                    <div class="inputs">
                        <input class="" type="number" name="p_quantity" placeholder="Quantity" required />
                    </div>
                </div>
                <div class="ProductBtn"><button type="submit">Submit</button></div>
            </form> 
        </section>
    </div>
     <!-- Add Most Shelling Product-->
  		<div class="MSProductContainer">
		    <h3>Add Most Selling Product</h3>
		    <div class="MSProduct">
			    <div class="box">
		            <form class="MSProductform" action="MSProduct.jsp" method="post">
		            	<input type="hidden" name="servletname" value="MSProduct">
		                <div class="MSInput"><input type="text" name="pname" placeholder="Product"></div>
		                <div class="MSBtn"><button type="submit">Set</button></div>
		            </form>
        		</div>
		    </div>
	    </div>
	    <!-- Add Best Rating Product-->
	    <div class="MSProductContainer">
		    <h3>Best Rating Product</h3>
		    <div class="MSProduct">
			    <div class="box">
		            <form class="MSProductform" action="MSProduct.jsp" method="post">
		            	<input type="hidden" name="servletname" value="BRProduct">
		                <div class="MSInput"><input type="text" name="pname" placeholder="Product"></div>
		                <div class="MSBtn"><button type="submit">Set</button></div>
		            </form>
        		</div>
		    </div>
	    </div>
	    
    </div>
    </div>

    
</body>
<script type="text/javascript" src="ProductJS.js"></script>
</html>
<%
	}
%>