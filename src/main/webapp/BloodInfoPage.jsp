    
<%@page import="com.bloodline.helper.ConnectionProvider"%>
<%@page import="com.bloodline.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.bloodline.entities.User" %>
    <%@page import="java.sql.*" %>
    <%@page import="com.bloodline.dao.*" %>
    
    <%
    
    User user=(User)session.getAttribute("currentUser");
    
    if(user==null){
    	response.sendRedirect("login.jsp");
    }
    
    
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Looking For Blood</title>
 <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
  
 


</head>
<body>




<div class="container text-center mt-5" >


<table class="table table-bordered table-red w-80  table-striped table-hover center">
  <thead>
    <tr>            
         <th>Name</th>    
         <th>City</th>       
         <th>Blood Group</th>  
         <th>Mobile</th>   
              </tr>
  </thead>
  <tbody>
                 <%
Connection con=ConnectionProvider.getConnection();
String bloodGroup=request.getParameter("blood_group");

String city=request.getParameter("city");

System.out.println(bloodGroup);

try {
	String q="select *from registration where bloodgroup=? and city=?";
	PreparedStatement pstmt=con.prepareStatement(q);
	pstmt.setString(1, bloodGroup);
	pstmt.setString(2, city);
	
	
	ResultSet set=pstmt.executeQuery();
	while(set.next()) {
				
		%>		
					 <tr>
                       
                        <td><%=set.getNString("firstname")%> </td>
                       
                      
                      
		
		 			
                       
                        <td><%=set.getNString("city")%> </td>
                        
                        <td><%=set.getNString("bloodgroup")%> </td>
                        <td><%=set.getNString("mobile")%> </td>
                        
                       
                      </tr>
                       
		<% 

	}
	
	
} catch (Exception e) {
	// TODO: handle exception
	e.printStackTrace();
}




%>
  
  
  
  
  
  
    
  </tbody>
</table>
</div>















<script
  src="https://code.jquery.com/jquery-3.6.4.min.js"
  integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8="
  crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

  <script src="./js/myjs.js" type="text/javascript" ></script> 
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script> 








</body>
</html>