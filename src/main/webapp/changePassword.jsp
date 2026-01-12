<%@ page import="java.lang.reflect.Method,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    // small helper to safely print strings
    public String safe(String s) {
        if (s == null) return "";
        return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;");
    }
%>
<%
    if (session == null || session.getAttribute("currentUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Change Password — BloodLine</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: linear-gradient(180deg,#f8fafc,#eef2ff); min-height:100vh; }
    .card { border-radius:12px; box-shadow: 0 8px 30px rgba(16,24,40,0.06); }
    .pw-strength { height:6px; border-radius:6px; background:#e9ecef; overflow:hidden; }
    .pw-strength > span { display:block; height:100%; width:0%; transition:width .25s ease; background:linear-gradient(90deg,#f97316,#e11d48); }
  </style>
</head>
<body>
<nav class="navbar navbar-light bg-white shadow-sm mb-4">
  <div class="container">
    <a class="navbar-brand" href="profile.jsp">← Back to Profile</a>
    <div class="d-none d-md-block small text-muted">Signed in as <strong><%= safe(userEmail) %></strong></div>
  </div>
</nav>

<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <% if (msgObj != null) {
           try {
               Class<?> mc = msgObj.getClass();
               String css = (String) mc.getMethod("getCssClass").invoke(msgObj);
               String content = (String) mc.getMethod("getContent").invoke(msgObj);
      %>
        <div class="alert <%= safe(css) %> alert-dismissible fade show">
          <strong><%= safe(content) %></strong>
          <button class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      <%     } catch (Exception e) { %>
        <div class="alert alert-info alert-dismissible fade show">
          <strong>Password change result.</strong>
          <button class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      <%   } } %>

      <div class="card p-4 mb-3">
        <h5 class="mb-3">Change Password</h5>
        <p class="small text-muted mb-4">Choose a secure password. Do not share it with anyone.</p>

        <form id="changePwForm" action="ChangePasswordServlet" method="post" novalidate>
          <div class="mb-3">
            <label class="form-label">Current password</label>
            <div class="input-group">
              <input id="oldPass" name="oldPass" type="password" class="form-control" required>
              <button type="button" class="btn btn-outline-secondary" data-toggle="toggle" data-target="#oldPass"><i class="bi bi-eye"></i></button>
            </div>
            <div class="form-text">Enter your existing password to confirm.</div>
          </div>

          <div class="mb-3">
            <label class="form-label">New password</label>
            <div class="input-group">
              <input id="newPass" name="newPass" type="password" class="form-control" minlength="8" required>
              <button type="button" class="btn btn-outline-secondary" data-toggle="toggle" data-target="#newPass"><i class="bi bi-eye"></i></button>
            </div>
            <div class="pw-strength my-2" aria-hidden="true"><span id="strengthBar"></span></div>
            <div id="strengthText" class="small text-muted">Use at least 8 characters with letters and numbers.</div>
          </div>

          <div class="mb-3">
            <label class="form-label">Confirm new password</label>
            <div class="input-group">
              <input id="confirmPass" name="confirmPass" type="password" class="form-control" minlength="8" required>
              <button type="button" class="btn btn-outline-secondary" data-toggle="toggle" data-target="#confirmPass"><i class="bi bi-eye"></i></button>
            </div>
            <div id="confirmMsg" class="small mt-1"></div>
          </div>

          <div class="d-flex justify-content-between align-items-center mt-4">
            <a class="btn btn-light" href="profile.jsp">Cancel</a>
            <button id="submitBtn" type="submit" class="btn btn-primary">Change password</button>
          </div>
        </form>
      </div>

      <div class="text-center small text-muted">Tip: Use a unique password you don't reuse on other sites.</div>
    </div>
  </div>
</div>

<!-- Bootstrap & icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<script>
  // Password visibility toggles: buttons with data-toggle="toggle"
  document.querySelectorAll('[data-toggle="toggle"]').forEach(function(btn){
    btn.addEventListener('click', function(){
      var target = document.querySelector(btn.getAttribute('data-target'));
      if (!target) return;
      if (target.type === 'password') {
        target.type = 'text';
        btn.innerHTML = '<i class="bi bi-eye-slash"></i>';
      } else {
        target.type = 'password';
        btn.innerHTML = '<i class="bi bi-eye"></i>';
      }
    });
  });

  // basic strength estimator
  function estimateStrength(pw) {
    var score = 0;
    if (!pw) return 0;
    if (pw.length >= 8) score += 1;
    if (/[A-Z]/.test(pw)) score += 1;
    if (/[0-9]/.test(pw)) score += 1;
    if (/[^A-Za-z0-9]/.test(pw)) score += 1;
    return score; // 0..4
  }

  var newPass = document.getElementById('newPass');
  var strengthBar = document.getElementById('strengthBar');
  var strengthText = document.getElementById('strengthText');
  var confirmPass = document.getElementById('confirmPass');
  var confirmMsg = document.getElementById('confirmMsg');
  var form = document.getElementById('changePwForm');

  newPass && newPass.addEventListener('input', function(){
    var s = estimateStrength(newPass.value);
    var pct = (s/4)*100;
    strengthBar.style.width = pct + '%';
    if (s <= 1) {
      strengthBar.style.background = '#f97316'; // orange
      strengthText.textContent = 'Weak password — try adding uppercase, numbers, symbols.';
    } else if (s == 2) {
      strengthBar.style.background = '#f59e0b';
      strengthText.textContent = 'Fair — consider adding symbols and uppercase letters.';
    } else if (s == 3) {
      strengthBar.style.background = '#10b981';
      strengthText.textContent = 'Good — almost there.';
    } else {
      strengthBar.style.background = '#0ea5e9';
      strengthText.textContent = 'Strong password.';
    }
    // also revalidate confirm
    checkConfirm();
  });

  function checkConfirm() {
    if (!confirmPass || !newPass) return;
    if (confirmPass.value.length === 0) {
      confirmMsg.textContent = '';
      confirmMsg.className = 'small mt-1';
      return;
    }
    if (confirmPass.value === newPass.value) {
      confirmMsg.textContent = 'Passwords match';
      confirmMsg.className = 'small text-success mt-1';
    } else {
      confirmMsg.textContent = 'Passwords do not match';
      confirmMsg.className = 'small text-danger mt-1';
    }
  }

  confirmPass && confirmPass.addEventListener('input', checkConfirm);

  // client-side final validation before submitting
  form && form.addEventListener('submit', function(e){
    // require new password length >= 8
    if (newPass.value.length < 8) {
      e.preventDefault();
      alert('New password must be at least 8 characters long.');
      newPass.focus();
      return false;
    }
    if (newPass.value !== confirmPass.value) {
      e.preventDefault();
      alert('New password and confirm password do not match.');
      confirmPass.focus();
      return false;
    }
    // allow form to submit; server will validate old password etc.
    return true;
  });
</script>
</body>
</html>
