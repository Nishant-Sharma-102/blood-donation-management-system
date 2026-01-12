<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want to Donate Blood | BloodLine</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<style>
  body {
    background-color: #fff5f5;
  }
  .donate-container {
    margin-top: 50px;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
  }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: brown;">
  <a class="navbar-brand" href="index.html"><span class="fa fa-tint"></span> BloodLine</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" 
          aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
      <li class="nav-item"><a class="nav-link" href="looking_for_blood.jsp">Looking for Blood</a></li>
      <li class="nav-item active"><a class="nav-link" href="">Want to Donate Blood</a></li>
      <li class="nav-item"><a class="nav-link" href="#">Blood Bank</a></li>
      <li class="nav-item"><a class="nav-link" href="#">Tips</a></li>
      <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
      <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
    </ul>
  </div>
</nav>
<!-- End Navbar -->

<div class="container donate-container">
  <h2 class="text-center text-danger mb-4">Become a Blood Donor</h2>
  <p class="text-center text-muted">Fill in your details below and help save lives ❤️</p>

  <form action="DonateServlet" method="post">
    <div class="form-row">
      <div class="form-group col-md-6">
        <label>First Name</label>
        <input type="text" name="fname" class="form-control" placeholder="Enter first name" required>
      </div>
      <div class="form-group col-md-6">
        <label>Last Name</label>
        <input type="text" name="lname" class="form-control" placeholder="Enter last name" required>
      </div>
    </div>

    <div class="form-row">
      <div class="form-group col-md-6">
        <label>Email</label>
        <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
      </div>
      <div class="form-group col-md-6">
        <label>Mobile Number</label>
        <input type="text" name="mobile" class="form-control" placeholder="Enter your mobile number" required>
      </div>
    </div>

    <div class="form-row">
      <div class="form-group col-md-6">
        <label>Blood Group</label>
        <select name="bloodgroup" class="form-control" required>
          <option value="">-- Select --</option>
          <option value="A+">A+</option>
          <option value="A-">A-</option>
          <option value="B+">B+</option>
          <option value="B-">B-</option>
          <option value="O+">O+</option>
          <option value="O-">O-</option>
          <option value="AB+">AB+</option>
          <option value="AB-">AB-</option>
        </select>
      </div>
      <div class="form-group col-md-6">
        <label>Gender</label>
        <select name="gender" class="form-control" required>
          <option value="">-- Select --</option>
          <option value="Male">Male</option>
          <option value="Female">Female</option>
          <option value="Other">Other</option>
        </select>
      </div>
    </div>

    <div class="form-row">
      <div class="form-group col-md-6">
        <label>State</label>
        <input type="text" name="state" class="form-control" placeholder="Enter your state">
      </div>
      <div class="form-group col-md-6">
        <label>City</label>
        <input type="text" name="city" class="form-control" placeholder="Enter your city">
      </div>
    </div>

    <div class="form-group">
      <label>Date of Birth</label>
      <input type="date" name="dob" class="form-control">
    </div>

    <div class="text-center mt-4">
      <button type="submit" class="btn btn-danger btn-lg">Submit & Become Donor</button>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
