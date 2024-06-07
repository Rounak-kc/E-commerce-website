package com.digi.model;

import java.io.InputStream;
import java.sql.*; 
import java.util.ArrayList;
import java.util.HashMap;

public class DAO {
	private Connection c = null;
	public DAO() throws SQLException,ClassNotFoundException{
		Class.forName("com.mysql.jdbc.Driver");
		c=DriverManager.getConnection("jdbc:mysql://localhost:3306/digi_shop","root","Rounak123@");
		
	}
	
	public void closeConnection() throws SQLException{
		c.close();
	}
	
	public String adminLogin(String id,String password) throws SQLException{
		PreparedStatement p=c.prepareStatement("SELECT * FROM admin_login where id = ? and password = ?");
		p.setString(1, id);
		p.setString(2,password);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return rs.getString("name");
		}else {
			return null;
		}
	}
	
	//DataBase connection to read data for user login in user table
	public String userLogin(String email,String password) throws SQLException{
		PreparedStatement p=c.prepareStatement("SELECT * FROM user where email = ? and password = ?");
		p.setString(1, email);
		p.setString(2,password);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return rs.getString("name");
		}else {
			return null;
		}
	}
	
	public void addEnquiry(String name,String phone) throws SQLException{
		PreparedStatement p=c.prepareStatement("insert into enquiry (name,phone,e_date,status) values(?,?,CURRENT_DATE,'Pending')");
		p.setString(1, name);
		p.setString(2,phone);
		p.executeUpdate();
	}
	
	public ArrayList<HashMap<String,Object>> getAllEnquiries() throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from enquiry order by id DESC");
		ResultSet rs=p.executeQuery();
		ArrayList<HashMap<String,Object>> enquiries=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String,Object> enquiry=new HashMap<String,Object>();
			enquiry.put("id", rs.getInt("id"));
			enquiry.put("name", rs.getString("name"));
			enquiry.put("phone", rs.getString("phone"));
			enquiry.put("e_date", rs.getString("e_date"));
			enquiry.put("status", rs.getString("status"));
			enquiries.add(enquiry);
		}
		return enquiries;	
	}
	
	//DB connection for Update status attribute in Enquiry table 
	public void changeEnquiryStatus(int id) throws SQLException {
		PreparedStatement p=c.prepareStatement("update enquiry set status='Done' where id=?");
		p.setInt(1,id);
		p.executeUpdate();
	}
	
	//DB connection for add values to the category table in name attribute
	public String addCategory(String name) throws SQLException{       
		PreparedStatement p=c.prepareStatement("insert into category values (?)");
		p.setString(1, name);
		
		try {
			p.executeUpdate();
			return "Success";
		}catch(SQLIntegrityConstraintViolationException e) { //This Exception For Unique Attribute Exception 
			return "Already Exist";
		}
	}
	
	//DB connection for read name values from category table
	public ArrayList<String> getAllCategory() throws SQLException{        
		PreparedStatement p=c.prepareStatement("select * from category");
		ResultSet rs=p.executeQuery();
		ArrayList<String> categories=new ArrayList<String>();
		while(rs.next()){
			categories.add(rs.getString("name"));
		}
		return categories;
	}
	
	//Database connection to delete row values from category table
	public void deleteCategory(String name) throws SQLException {
		PreparedStatement p=c.prepareStatement("delete from category where name=?");
		p.setString(1,name);
		p.executeUpdate();
	}
	
	//Database connection to delete row values from product table
	public void deleteProduct(String name) throws SQLException {
		PreparedStatement p=c.prepareStatement("delete from product where name=?");
		p.setString(1,name);
		p.executeUpdate();
	}
	
	//DataBase connection to increase  quantity in product table 
	public void addQuantity(String qty,String name) throws SQLException {
		PreparedStatement p=c.prepareStatement("update product set quantity="+qty+"where name=?");
		p.setString(1, name);
		p.executeUpdate();
	}
	
	
	public String addProduct(HashMap<String,Object> product) throws SQLException {
		PreparedStatement p=c.prepareStatement("insert into product (name,price,company,category,info,quantity,image) values(?,?,?,?,?,?,?)");
		p.setString(1,(String)product.get("name"));
		p.setInt(2,(int)product.get("price"));
		p.setString(3,(String)product.get("company"));
		p.setString(4,(String)product.get("category"));
		p.setString(5,(String)product.get("info"));
		p.setString(6,(String)product.get("quantity"));
		p.setBinaryStream(7,(InputStream)product.get("image"));
		try {
			p.executeUpdate();
			return "Success";
		}catch(SQLIntegrityConstraintViolationException e) {
			return "Fail to add (Already Exist)";
		}
	}
	
	//DataBase connection to read All Attribute's value of Table(Product)  
	public ArrayList<HashMap<String,Object>> getAllProduct() throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from product order by category DESC");
		ResultSet rs=p.executeQuery();
		ArrayList<HashMap<String,Object>> products=new ArrayList<HashMap<String,Object>>();
		while(rs.next()){
			HashMap<String,Object> product=new HashMap<String,Object>();
			product.put("name", rs.getString("name"));
			product.put("price", rs.getInt("price"));
			product.put("company", rs.getString("company"));
			product.put("category", rs.getString("category"));
			product.put("info", rs.getString("info"));
			product.put("quantity", rs.getString("quantity"));
			products.add(product);
		}
		return products; 
	}
	
	
	//DataBase Connection to get All value from product table
	public ArrayList<HashMap<String,Object>> getProductInfo(String name) throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from product where name = ? ");
		p.setString(1,name);
		ResultSet rs=p.executeQuery();
		ArrayList<HashMap<String,Object>> products=new ArrayList<HashMap<String,Object>>();
		while(rs.next()){
			HashMap<String,Object> product=new HashMap<String,Object>();
			product.put("name", rs.getString("price"));
			product.put("price", rs.getInt("company"));
			product.put("category", rs.getString("category"));
			product.put("category", rs.getString("info"));
			product.put("category", rs.getString("quantity"));
			products.add(product);
		}
		return products; 
	}
	
	//DataBase connection to read the image from product table
	public  byte[] getProductImage(String name) throws SQLException{
		PreparedStatement p=c.prepareStatement("select image from product where name=?");
		p.setString(1,name);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return rs.getBytes("image");
		}else{
			return null;
		}
	}
	
	//DataBase connection to insert user signUp data to user table
	public String addUser(String name,String email,String phone,String password) throws SQLException{
		PreparedStatement p=c.prepareStatement("insert into user(email,name,phone,password) values(?,?,?,?)");
		p.setString(1, email);
		p.setString(2, name);
		p.setString(3, phone);
		p.setString(4, password);
		try {
			p.executeUpdate();
			return "success";
		}catch(SQLIntegrityConstraintViolationException e) {
			return "Fail";
		}
	}
	
	public String addUserToCurrentAddress(String email) throws SQLException{
		PreparedStatement p=c.prepareStatement("insert into currentaddress (email) values(?)");
		p.setString(1, email);
		//p.setString(2, address);
		try {
			p.executeUpdate();
			return "success";
		}catch(SQLIntegrityConstraintViolationException e) {
			return "Fail";
		}
	}
	
	//DataBase connection to get values of Table(Product)  for product card 
		public ArrayList<HashMap<String,Object>> getProductLikeName(String name) throws SQLException{
			PreparedStatement p=c.prepareStatement("select * from product where name like ? and quantity>0  order by price DESC");
			p.setString(1,"%"+name+"%");
			ResultSet rs=p.executeQuery();
			ArrayList<HashMap<String,Object>> products=new ArrayList<HashMap<String,Object>>();
			while(rs.next()){
				HashMap<String,Object> product=new HashMap<String,Object>();
				product.put("name", rs.getString("name"));
				product.put("price", rs.getInt("price"));
				product.put("category", rs.getString("category"));
				products.add(product);
			}
			return products; 
		}
		
		
		//DataBase connection to read the value of cart table
		public void addCart(String email,String item) throws SQLException{
			PreparedStatement p=c.prepareStatement("select * from cart where email=?");
			p.setString(1, email);
			ResultSet rs=p.executeQuery();
			if(rs.next()) {   //if next query return true from dataBase then if condition will run otherwise else condition will run 
				String i=rs.getString("item");
				p=c.prepareStatement("update cart set item=? where email=?");
				p.setString(1,i+","+item);
				p.setString(2, email);
				p.executeUpdate();
			}else {
				p=c.prepareStatement("insert into cart (email,item) value (?,?)");
				p.setString(1, email);
				p.setString(2, item);
				p.executeUpdate();
			}
		}
		
		//DataBase connection for count item number which are saved in cart table
		public int itemCount(String email) throws SQLException{
			PreparedStatement p=c.prepareStatement("select * from cart where email=?");
			p.setString(1, email);
			ResultSet rs=p.executeQuery();
			if(rs.next()) {
				String item=rs.getString("item");
				String i[]=item.split(",");
				return i.length;
			}else {
				return 0;
			}
		}
		//DataBase connection to get item from cart table
		public String[] getAllCartItemByEmail(String email) throws SQLException{
				PreparedStatement p=c.prepareStatement("select * from cart where email=?");
				p.setString(1, email);
				ResultSet rs=p.executeQuery();
				if(rs.next()) {
					String all_item=rs.getString("item");
					String array_item[]=all_item.split(",");
					return array_item;
				}else {
					return null;
				}
		}
		//DataBase connection to get price of product from product table
		public int getItemPrice(String item) throws SQLException{
			PreparedStatement p=c.prepareStatement("select price from product where name=?");
			p.setString(1, item);
			ResultSet rs=p.executeQuery();
			if(rs.next()) {
				int price=rs.getInt("price");
				return price;
			}else {
				return 0;
			}
		}
		
		//DataBase connection to delete the item part from cart table
		public void removeCartItem(String email,String item) throws SQLException{
			PreparedStatement p=c.prepareStatement("select * from cart where email=?");
			p.setString(1, email);
			ResultSet rs=p.executeQuery();
			if(rs.next()) {
				String Items=rs.getString("item"); //get item from cart table
				String array_item[]=Items.split(","); //split item into sub items
				ArrayList<String> newItem=new ArrayList<>();  //Create object of ArrayList
				for(int i=0;i<array_item.length;i++) {
					newItem.add(array_item[i]);  //add array item into ArrayList by applying loop
				}
				newItem.remove(item);  //remove selected item from ArrayList
				Items="";
				for(String string : newItem) {  
					Items += ","+string;  //Concatenate all Split items into one string variable by using loop
				}
				Items=Items.substring(1,Items.length()); //pick the string from index 1 to last index and remove the 0th index string
				p=c.prepareStatement("update cart set item=? where email=?");
				p.setString(1, Items);
				p.setString(2, email);
				p.executeUpdate();
			}
		}
		
		//DataBase connection to read the image from product table
		public  byte[] getCategoryImg(String name) throws SQLException{
			PreparedStatement p=c.prepareStatement("select img from category where name=?");
			p.setString(1,name);
			ResultSet rs=p.executeQuery();
			if(rs.next()) {
				return rs.getBytes("img");
			}else{
				return null;
			}
		}
		
		//Set value in msproduct table in database
		public  String setMSProduct(String msname) throws SQLException{
			PreparedStatement p=c.prepareStatement("insert into msproduct (name) values (?)");
			p.setString(1, msname);
			try {
				p.executeUpdate();
				return "Selected";
			}catch(SQLIntegrityConstraintViolationException e) {
				return "Duplicate Item";
			}
		}

		//DB connection for read msproduct table
		public  ArrayList<String> getMSProduct() throws SQLException{
			PreparedStatement p=c.prepareStatement("select * from msproduct");
			ResultSet rs=p.executeQuery();
			ArrayList<String> msproducts=new ArrayList<String>();
			while(rs.next()) {
				msproducts.add(rs.getString("name"));
			}
			return msproducts;
		}
		
		//Set value in msproduct table in database
		public  String setBRProduct(String brname) throws SQLException{
			PreparedStatement p=c.prepareStatement("insert into brproduct (name) values (?)");
			p.setString(1, brname);
			try {
				p.executeUpdate();
				return "Selected";
			}catch(SQLIntegrityConstraintViolationException e) {
				return "Duplicate Item";
			}
		}
		
		//DB connection for read msproduct table
		public  ArrayList<String> getBRProduct() throws SQLException{
			PreparedStatement p=c.prepareStatement("select * from brproduct");
			ResultSet rs=p.executeQuery();
			ArrayList<String> brproducts=new ArrayList<String>();
			while(rs.next()) {
				brproducts.add(rs.getString("name"));
			}
			return brproducts;
		}
		
		public ArrayList<String> getAddressByEmail(String email) throws SQLException{
			PreparedStatement p=c.prepareStatement("select address from address where email=?");
			p.setString(1, email);
			ResultSet rs=p.executeQuery();
			ArrayList<String> addresses=new ArrayList<>();
			while(rs.next()) {
				addresses.add(rs.getString("address"));
			}
			return addresses;
		}
		
		public void setAddress(String email,String address) throws SQLException{
			PreparedStatement p=c.prepareStatement("insert into address (email,address) values (?,?)");
			p.setString(1, email);
			p.setString(2, address);
			p.executeUpdate();
		}
		
		public void setCurrentAddress(String email,String address) throws SQLException{
			PreparedStatement p=c.prepareStatement("update currentaddress set address=? where email=?");
			p.setString(1, address);
			p.setString(2,email );
			p.executeUpdate();
		}
		
		public String getCurrentAddress(String email) throws SQLException{
			PreparedStatement p=c.prepareStatement("select address from currentaddress where email = ?");
			p.setString(1, email);
			ResultSet rs=p.executeQuery();
			if(rs.next()) {
				String address=(rs.getString("address"));
				return address;
			}
			return "Enter Address";
		}
		
		public void setorderInfo(String email,String address) throws SQLException{
			String[] items=getAllCartItemByEmail(email);
			String orderItems="";
			int total=0;
			for(String item:items) {
				int price=getItemPrice(item);
				total+=price;
				orderItems+=","+item+":-"+price;
			}
			orderItems=orderItems.substring(1,orderItems.length());
			PreparedStatement p=c.prepareStatement("insert into orderinfo (email,address,total,order_date,order_item,status) values (?,?,?,CURRENT_DATE,?,'pending')");
			p.setString(1, email);
			p.setString(2, address);
			p.setInt(3, total);
			p.setString(4, orderItems);
			p.executeUpdate();
//			p=c.prepareStatement("delete from cart where email=?");
//			p.setString(1, email);
//			p.executeUpdate();
		}
		
		public ArrayList<HashMap<String,Object>> getorderInfoByEmail(String email) throws SQLException{
			PreparedStatement p=c.prepareStatement("select * from orderinfo where email = ?");
			p.setString(1, email);
			ResultSet rs =p.executeQuery();
			ArrayList<HashMap<String,Object>> orders=new ArrayList<HashMap<String,Object>>();
			while(rs.next()) {
				HashMap<String,Object> order=new HashMap<String,Object>();
				order.put("id",rs.getString("id"));
				order.put("address",rs.getString("address"));
				order.put("total",rs.getInt("total"));
				order.put("order_date",rs.getString("order_date"));
				order.put("order_item",rs.getString("order_item"));
				order.put("status",rs.getString("status"));
				orders.add(order);
			}
			return orders;
		}
		
		public void changeOrderStatus(String id,String status) throws SQLException{
			PreparedStatement p=c.prepareStatement("update orderinfo set status = ? where id = ?");
			p.setString(1, status);
			p.setString(2, id);
			p.executeUpdate();
		}
		
}



