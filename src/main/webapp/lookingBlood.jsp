<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.bloodline.entities.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 <link href="css/mystyle.css" rel="stylesheet" type="text/css"/> 
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="assets/img/picon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
<link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="assets/css/style.css" rel="stylesheet">




<title>LookingBlood</title>
</head>
<body>


<!-- ======= Header ======= -->
<header id="header" class="fixed-top" style="background-color: white;" >
<div class="container d-flex align-items-center justify-content-between" >

<h1 class="logo"><a href="index.html"> <span  > <img class="logo1" src="assets/img/Logo.png" alt="logo"> </span> </a></h1>
<!-- Uncomment below if you prefer to use an image logo -->
<!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

<nav id="navbar" class="navbar">
  <ul>
    <li><a class="nav-link scrollto " href="index.html">HOME</a></li>
    <li><a class="nav-link scrollto" href="lookingBlood.jsp">LOOKING FOR BLOOD</a></li>
    <li><a class="nav-link scrollto" href="#services">WANT TO DONATE BLOOD</a></li>
    <li><a class="nav-link scrollto " href="#work">BLOOD BANK</a></li>
    <li><a class="nav-link scrollto " href="#tips">TIPS</a></li>
    <li><a class="nav-link scrollto " href="#team">TEAM</a></li>
    <li><a class="nav-link scrollto " href="login.jsp">LOGIN</a></li>
    
    </li>
    <li><a class="nav-link scrollto" href="#contact">Contact</a></li>
  </ul>
  <i class="bi bi-list mobile-nav-toggle"></i>
</nav><!-- .navbar -->

</div>
</header><!-- End Header -->




    
    
<div id="hero" class=" route bg-image-m bimg"  style="background-image: url(assets/img/bc4.jpg); margin-top: 100px;   width: 100%;">
  <div class="overlay-itro"></div>
  <div class="hero-content display-table">
    <div class="table-cell">
      <div class="container">
    
    
    
    

    <main class="primary-background">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-header primar-background text-center primary-background">
                        <h3> <span class="fa fa-address-book"></span> Find Blood </h3>

                    </div>
                    
                    <%
                    Message m= (Message)session.getAttribute("msg");
                    if(m!=null){
                    	%>
                    	
                    	<div class="alert <%=m.getCssClass() %>" role="alert">
  					<%= m.getContent() %>
					</div>
                    	
                    	
                    	<%
                    	
                    	session.removeAttribute("msg");
                    	
                    	
                    	
                    }
                    
                    %>
                    
                    
                    
                    
                    
                    <div class="card-body">

                         <form  action="BloodInfoPage.jsp"method="GET" style=" width: 100%;" >
       
        <br>
       
        
        <div class="form-group">
          <label for="blood-group">Blood Group<label style="color: red;" > *</label></label><br>
         <select name="blood_group" id="blood_group">
          <option>Select Blood Group</option>
          <option value="A+">A+</option>
          <option value="A-">A-</option>
          <option value="B+">B+</option>
          <option value="B-">B-</option>
          <option value="AB+">AB+</option>
          <option value="AB-">AB-</option>
          <option value="O+">O+</option>
          <option value="O-">O-</option>
          <option value="A1+">A1+</option>
          <option value="A1-">A1-</option>
          <option value="A2+">A2+</option>
          <option value="A2-">A2-</option>

         </select>


         
        </div>
        
      
        <br>

        <div class="form-group">
          <label for="patient-name">State  Name<label style="color: red;" > *</label></label>
         <br>
          <select name="patient_state" id="patient_state">
          <option>Select State</option>
          <option value="Andhra Pradesh">Andhra Pradesh</option>
          <option value="Arunachal Pradesh">Arunachal Pradesh</option>
          <option value="Assam">Assam</option>
          <option value="Bihar">Bihar</option>
          <option value="Chhattisgarh">Chhattisgarh</option>
          <option value="Goa">Goa</option>
          <option value="Gujarat">Gujarat</option>
          <option value="Haryana">Haryana</option>
          <option value="Himachal">Himachal</option>
          <option value="Jharkhand">Jharkhand</option>
          <option value="Karnataka">Karnataka</option>
          <option value="Kerala">Kerala</option>
          <option value="Madhya Pradesh">Madhya Pradesh</option>
          <option value="Maharashtra">Maharashtra</option>
          <option value="Manipur	Imphal">Manipur	Imphal</option>
          <option value="Meghalaya">Meghalaya</option>
          <option value="Mizoram	Aizawl">Mizoram	Aizawl</option>
          <option value="Nagaland">Nagaland</option>
          <option value="Odisha">Odisha</option>
          <option value="Punjab">Punjab</option>
          <option value="Rajasthan">Rajasthan</option>
          <option value="Sikkim">Sikkim</option>
          <option value="Tamil Nadu">Tamil Nadu</option>
          <option value="Telangana">Telangana</option>
          <option value="Tripura	Agartala">Tripura	Agartala</option>
          <option value="Uttar Pradesh">Uttar Pradesh</option>
          <option value="Uttarakhand">Uttarakhand</option>
          <option value="West Bengal">West Bengal</option>
         </select>
        </div>
        <br>
        
        
         <div class="form-group">
          <label for="city">City<label style="color: red;" > *</label></label>
          <input name="city" type="text" class="form-control" id="city" placeholder="Enter Patient pin Code">
        </div>
        <br>
       
        
    
       <button id="submit-btn" type="submit" class="btn btn-primary">SUBMITT YOUR REQUEST</button>
      </form>

                    </div>

                </div>

            </div>

        </div>
    </main>




      </div>
    </div>
  </div>
</div><!-- End Hero Section -->













   









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