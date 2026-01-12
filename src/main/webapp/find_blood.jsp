<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

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







<title>Registration Page</title>
</head>
<body  >


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



<!-- ======= Hero Section ======= -->
<div id="hero" class=" route bg-image-m bimg"  style="background-image: url(assets/img/bg1.jpg); margin-top: 100px;   width: 100%;">
<div class="overlay-itro"></div>
<div class="hero-content display-table">
<div class="table-cell">
  <div class="container">


    <main >
      <div class="container" style="width: 100%; " >
      <div class="col-md-4 offset-md-4">
      <div class="card " style=" width: 120%;">   
      <div class="card-header text-center">
      <span class="fa fa-3x fa-user-circle"  ></span> <br> <h2> Request for Blood </h2>
      </div>
      <div class="card-body" style="width: 100%; "  >
      
      <form  action="RequestBlood"method="POST" style=" width: 100%;" >
       <div class="form-group">
          <label for="patient-name"> Patient Name<label style="color: red;" > *</label></label>
          <input name="patient_name" type="text" class="form-control" id="patient_name" placeholder="Enter Patient Name">
        </div>
        <br>
        
         <div class="form-group">
          <label for="attendee-name">Attendee  Name<label style="color: red;" > *</label></label>
          <input name="attendee_name" type="text" class="form-control" id="attendee_name" placeholder="Enter Attendee Name">
        </div>
        <br>
        
        
        
       
       
        <div class="form-group">
          <label for="attendee-mobile"> Attendee Mobile<label style="color: red;" > *</label></label>
          <input name="attendee_mobile" type="number" class="form-control" id="attendee_mobile" placeholder="Enter your mobile number">
        </div>
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
          <label for="patient-dob">Date Of Birth<label style="color: red;" > *</label></label>
          <input name="patient_dob" type="date" class="form-control" id="patient_dob" placeholder="Enter Birthday">
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
          <label for="pin-code">Pin Code<label style="color: red;" > *</label></label>
          <input name="pin_code" type="text" class="form-control" id="pin_code" placeholder="Enter Patient pin Code">
        </div>
        <br>
        
        <div class="form-group">
          <label for="patient-name">City  Name<label style="color: red;" > *</label></label>
          <input name="city_name" type="text" class="form-control" id="city_name" placeholder="Enter Patient City Name">
        </div>
        <br>
        

        <div class="form-group">
          <label for="require-date">Required Date<label style="color: red;" > *</label></label>
          <input name="require_date" type="date" class="form-control" id="require_date" placeholder="Enter Date">
        </div>
        <br>

        
        <div class="form-group">
          <label for="gender">Select Gender<label style="color: red;" > *</label></label><br>
          <input type="radio"  id="gender" name="gender" value="Male"> Male
          <input type="radio"  id="gender" name="gender" value="Female" > Female
        </div>
        <br>

        
        
        
        

        <div class="form-group">
          <label for="form">Requisition Form from doctor</label></label>
          <input name="form" type="FILE" class="form-control" id="form" placeholder="Enter Birthday">
        </div>
        <br>
        
        
        <div class="form-group">
          <label for="additional-note">Additional note to potential donors</label>
          <input  name="additional_note" type="text-area" class="form-control" id="additional_note">
        </div>
        <br>
        
        
        <div class="form-check">
          <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
          <label class="form-check-label" for="exampleCheck1">Agree Term & Condition<label style="color: red;" > *</label></label>
        </div>
        <br>
        <div class="form-check">
          <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
          <label class="form-check-label" for="exampleCheck1">It is critical & emergency</label></label>
        </div>
        <br>
       <div class="container text-center" id="loader" style="display: none;" >
        <span class="fa fa-refresh fa-spin fa-4x"></span><br>
        <h4>Please wait...</h4>
       </div>
       <button id="submit-btn" type="submit" class="btn btn-primary">SUBMITT YOUR REQUEST</button>
      </form>
      
      
      
      </div>
      
      <div class="card-footer"></div>
      
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






<script>
$(document).ready(function(){
  console.log("loaded.......")
  $('#reg-form').on('submit',function(event){

    event.preventDefault();
    let form=new FormData(this);

    $('#submit-btn').hide();
    $('#loader').show();




    //send register servlet

    $.ajax({
      url: "RegisterServlet",
      type: 'POST',
      data: form,
      success: function(data, textstatus, jqXHR){
        console.log(data)
        $('#submit-btn').show();
        $('#loader').hide();
        
        if(data.trim()=='done'){
          swal("Registered Successfully.. we redirection to loging page")
          .then((value) => {
          window.location="login.jsp"
        });
      }
      else{
        swal(data);
      }

       

      },
      error: function(jqXHR, textstatus, errorThrown){
        console.log(jqXHR)
        $('#submit-btn').show();
        $('#loader').hide();
        swal("Somthing went wrong !!")
       

      },
      processData:false,
      contentType: false

    });

  });


});
</script>



</body>
</html>