<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Register — BloodLine Hospital</title>

  <!-- Tailwind -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Font Awesome (loader) -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        crossorigin="anonymous"/>

  <style>
    .bg-blood-drop {
      background-image: url('assets/img/blood-drop-bg.jpg');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      position: relative;
    }
    .overlay-dark {
      position: absolute;
      inset: 0;
      background: rgba(0,0,0,0.65);
      z-index: 0;
    }
    .bg-pulse::after {
      content: "";
      position: absolute;
      inset: 0;
      background: radial-gradient(circle at 40% 30%, rgba(255,0,35,0.15), transparent 50%),
                  radial-gradient(circle at 70% 70%, rgba(255,0,35,0.10), transparent 50%);
      animation: pulse 8s infinite ease-in-out;
      z-index: 1;
    }
    @keyframes pulse {
      0% { opacity: .55; }
      50% { opacity: .85; }
      100% { opacity: .55; }
    }
    .glass {
      background: rgba(255,255,255,0.06);
      backdrop-filter: blur(8px);
      border: 1px solid rgba(255,255,255,0.1);
      box-shadow: 0 10px 30px rgba(0,0,0,0.5);
      z-index: 10;
    }
    .nav-glass {
      background: rgba(0,0,0,0.45);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(255,255,255,0.12);
      z-index: 50;
    }
  </style>
</head>

<body class="min-h-screen text-gray-100">

<!-- NAVBAR -->
<header class="nav-glass fixed top-0 w-full py-3">
  <div class="max-w-7xl mx-auto px-6 flex items-center justify-between">
    <div class="flex items-center gap-3">
      <img src="assets/img/Logo.png" class="h-10 w-10" alt="Logo">
      <span class="text-lg font-bold text-red-400">BloodLine Hospital</span>
    </div>

    <nav class="hidden md:flex items-center gap-6 text-gray-200 text-sm font-medium">
      <a href="index.jsp" class="hover:text-white">Home</a>
      <a href="login.jsp" class="hover:text-white">Login</a>
      <a href="#contact" class="hover:text-white">Contact</a>
    </nav>
  </div>
</header>


<!-- MAIN -->
<main class="min-h-screen bg-blood-drop bg-pulse relative flex items-center justify-center pt-24">
  <div class="overlay-dark"></div>

  <div class="relative z-10 max-w-6xl mx-auto w-full px-6 py-12">
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">

      <!-- LEFT -->
      <section class="space-y-6">
        <h1 class="text-5xl font-extrabold leading-tight">
          Become a <span class="text-red-400">Lifesaver</span>
        </h1>
        <p class="text-gray-200 text-lg max-w-lg">
          Register as a donor today — BloodLine connects hospitals and patients instantly.
        </p>

        <ul class="space-y-3 text-gray-300">
          <li class="flex items-start gap-3"><span class="text-red-400 text-xl">❤️</span> Smart Donor Matching</li>
          <li class="flex items-start gap-3"><span class="text-red-400 text-xl">🏥</span> Trusted Hospital Network</li>
          <li class="flex items-start gap-3"><span class="text-red-400 text-xl">🔒</span> Secure Encrypted Data</li>
        </ul>
      </section>

      <!-- RIGHT (FORM) -->
      <section>
        <div class="glass rounded-2xl p-6 md:p-8">

          <h2 class="text-2xl font-bold text-red-300 mb-6">Donor Registration</h2>

          <form id="reg-form" action="RegisterServlet" method="POST" enctype="multipart/form-data"
                class="space-y-4" novalidate>

            <!-- First + Last Name -->
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="text-sm">First Name *</label>
                <input name="user_fname" required type="text"
                       class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
              </div>

              <div>
                <label class="text-sm">Last Name *</label>
                <input name="user_lname" required type="text"
                       class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
              </div>
            </div>

            <!-- Email -->
            <div>
              <label class="text-sm">Email *</label>
              <input name="user_email" required type="email"
                     class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
            </div>

            <!-- Mobile + Password -->
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="text-sm">Mobile *</label>
                <input name="user_mobile" required type="tel"
                       class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
              </div>

              <div>
                <label class="text-sm">Password *</label>
                <input name="user_password" required type="password"
                       class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
              </div>
            </div>

            <!-- Blood + DOB -->
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="text-sm">Blood Group *</label>
                <select name="user_blood" required
                        class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
                  <option value="">Select</option>
                  <option>A+</option><option>A-</option>
                  <option>B+</option><option>B-</option>
                  <option>AB+</option><option>AB-</option>
                  <option>O+</option><option>O-</option>
                </select>
              </div>

              <div>
                <label class="text-sm">Date of Birth *</label>
                <input name="user_dob" required type="date"
                       class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
              </div>
            </div>

            <!-- State + City -->
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="text-sm">State *</label>
                <input name="user_state" required type="text"
                       class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
              </div>

              <div>
                <label class="text-sm">City *</label>
                <input name="user_city" required type="text"
                       class="w-full mt-1 bg-white/10 border border-white/20 px-3 py-2 rounded-md">
              </div>
            </div>

            <!-- Gender -->
            <div>
              <label class="text-sm">Gender *</label>
              <div class="flex items-center gap-6 mt-2">
                <label><input type="radio" name="gender" value="Male" required> Male</label>
                <label><input type="radio" name="gender" value="Female"> Female</label>
                <label><input type="radio" name="gender" value="Other"> Other</label>
              </div>
            </div>

            <!-- HIV Positive -->
            <div>
              <label class="text-sm">Have you ever tested HIV Positive?</label>
              <div class="flex items-center gap-6 mt-2">
                <label class="flex items-center gap-2">
                  <input type="radio" name="positive" value="Yes"> Yes
                </label>
                <label class="flex items-center gap-2">
                  <input type="radio" name="positive" value="No" checked> No
                </label>
              </div>
            </div>

            <!-- Terms -->
            <div class="flex items-start gap-3 mt-2">
              <input name="check" type="checkbox" required class="mt-1">
              <label class="text-sm">I agree to the Terms & Conditions *</label>
            </div>

            <!-- Loader -->
            <div id="loader" class="hidden py-3 text-center text-gray-300">
              <i class="fas fa-spinner fa-spin fa-2x text-red-400"></i>
              <p class="mt-2">Processing...</p>
            </div>

            <!-- Submit -->
            <button id="submit-btn" type="submit"
                    class="w-full py-3 bg-red-500 hover:bg-red-600 text-white font-semibold rounded-md">
              Register Now
            </button>

          </form>

          <p class="mt-4 text-sm text-gray-300 text-center">
            Already registered?
            <a href="login.jsp" class="text-red-300 underline">Login</a>
          </p>

        </div>
      </section>

    </div>
  </div>
</main>


<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- AJAX -->
<script>
$(function(){
  $("#reg-form").submit(function(e){
    e.preventDefault();

    if (!this.checkValidity()) {
      this.reportValidity();
      return;
    }

    $("#submit-btn").prop("disabled", true).addClass("opacity-60");
    $("#loader").removeClass("hidden");

    $.ajax({
      url: "RegisterServlet",
      method: "POST",
      data: new FormData(this),
      processData: false,
      contentType: false,
      success: function(resp){
        $("#submit-btn").prop("disabled", false).removeClass("opacity-60");
        $("#loader").addClass("hidden");

        if (resp.trim() === "done") {
          alert("Registration Successful!");
          window.location = "login.jsp";
        } else {
          alert(resp);
        }
      },
      error: function(){
        $("#submit-btn").prop("disabled", false).removeClass("opacity-60");
        $("#loader").addClass("hidden");
        alert("Something went wrong.");
      }
    });
  });
});
</script>

</body>
</html>
