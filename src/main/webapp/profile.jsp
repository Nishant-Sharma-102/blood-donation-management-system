<%@ page import="java.lang.reflect.Method,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! 
    // Try a list of getter names on obj and return the first non-null String result
    public String tryGetString(Object obj, String... getters) {
        if (obj == null) return null;
        Class<?> c = obj.getClass();
        for (String g : getters) {
            try {
                Method m = c.getMethod(g);
                Object res = m.invoke(obj);
                if (res != null) return res.toString();
            } catch (Exception ignored) {}
        }
        return null;
    }

    // Safe string (non-null) + simple HTML escape
    public String safe(String s) {
        if (s == null) return "-";
        return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;");
    }

    // Build profile image path: if profile value is empty use default
    public String imagePath(String ctx, String profileFile) {
        if (profileFile == null || profileFile.trim().isEmpty()) {
            return ctx + "/assets/img/lucky.png";
        }
        if (profileFile.startsWith("pics/") || profileFile.startsWith("/pics/")) {
            return ctx + "/" + profileFile.replaceFirst("^/+", "");
        }
        return ctx + "/pics/" + profileFile;
    }
%>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Object userObj = sessionObj.getAttribute("currentUser");
    if (userObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // session overrides set by servlet (preferred)
    String fnameSess  = (String) sessionObj.getAttribute("profile_fname");
    String lnameSess  = (String) sessionObj.getAttribute("profile_lname");
    String emailSess  = (String) sessionObj.getAttribute("profile_email");
    String mobileSess = (String) sessionObj.getAttribute("profile_mobile");
    String citySess   = (String) sessionObj.getAttribute("profile_city");
    String stateSess  = (String) sessionObj.getAttribute("profile_state");
    String bloodSess  = (String) sessionObj.getAttribute("profile_blood");
    String profileSess = (String) sessionObj.getAttribute("profile_profile");

    // fallback to user object via reflection
    String fname = fnameSess != null ? fnameSess : tryGetString(userObj, "getFname","getFirstname","getFirstName","getName");
    String lname = lnameSess != null ? lnameSess : tryGetString(userObj, "getLame","getLname","getLastname","getLastName");
    String email = emailSess != null ? emailSess : tryGetString(userObj, "getEmai","getEmail","getUserEmail");
    String mobile = mobileSess != null ? mobileSess : tryGetString(userObj, "getMobile","getPhone","getContact");
    String city = citySess != null ? citySess : tryGetString(userObj, "getUserCity","getCity");
    String state = stateSess != null ? stateSess : tryGetString(userObj, "getState","getRegion");
    String blood = bloodSess != null ? bloodSess : tryGetString(userObj, "getBloodGroup","getBlood","getBg");
    String profileFile = profileSess != null ? profileSess : tryGetString(userObj, "getProfile","getProfileImage","getPhoto","getImage");

    if (fname == null) fname = "-";
    if (lname == null) lname = "-";
    if (email == null) email = "-";
    if (mobile == null) mobile = "-";
    if (city == null) city = "-";
    if (state == null) state = "-";
    if (blood == null) blood = "-";

    String ctx = request.getContextPath();
    String avatar = imagePath(ctx, profileFile);

    Object msgObj = sessionObj.getAttribute("msg");
    if (msgObj != null) {
        sessionObj.removeAttribute("msg");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>My Profile — BloodLine</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root{
            --accent:#6f42c1;
            --muted:#6c757d;
            --card-bg:#ffffff;
        }
        body { background: linear-gradient(180deg, #f8fafc 0%, #eef2ff 100%); min-height:100vh; }
        .profile-hero {
            background: linear-gradient(90deg, rgba(111,66,193,0.08), rgba(99,102,241,0.04));
            border-radius: .75rem;
            padding: 1.25rem;
            box-shadow: 0 6px 20px rgba(99,102,241,0.06);
        }
        .avatar {
            width:140px; height:140px; object-fit:cover; border-radius:50%;
            border:6px solid #fff; box-shadow: 0 6px 18px rgba(16,24,40,0.08);
        }
        .stat {
            text-align:center;
        }
        .profile-card { border-radius:12px; box-shadow:0 10px 30px rgba(16,24,40,0.04); }
        .small-muted { color:var(--muted); font-size:.9rem; }
        .chip { background: rgba(111,66,193,0.08); color:var(--accent); padding:.25rem .6rem; border-radius:999px; font-weight:600; }
        @media (max-width:767px){
            .avatar { width:110px; height:110px; }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="#">
      <span class="badge bg-gradient-primary me-2" style="background:var(--accent);border-radius:6px;padding:.45rem .6rem;color:#fff;">BL</span>
      <span class="fw-bold">BloodLine</span>
    </a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto align-items-center">
        <li class="nav-item me-2"><a class="nav-link" href="index.html">Home</a></li>
        <li class="nav-item me-2"><a class="nav-link" href="/donors.jsp">Donors</a></li>
        <li class="nav-item"><a class="btn btn-outline-secondary btn-sm" href="index.html">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<main class="container my-5">

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
            <strong>Profile updated.</strong>
            <button class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <%   } } %>

    <div class="profile-hero p-3 mb-4">
        <div class="row g-3 align-items-center">
            <div class="col-sm-auto text-center">
                <img id="mainAvatar" src="<%= avatar %>" alt="avatar" class="avatar">
            </div>
            <div class="col">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <h3 class="mb-0"><%= safe(fname) %> <span class="text-muted"><%= safe(lname) %></span></h3>
                        <p class="small-muted mb-1"><i class="bi bi-geo-alt-fill me-1"></i> <%= safe(city) %> • <%= safe(state) %></p>
                        <div class="d-flex gap-2 align-items-center">
                            <span class="chip">Blood: <strong class="ms-2"><%= safe(blood) %></strong></span>
                            <span class="small-muted">|</span>
                            <span class="small-muted"><i class="bi bi-envelope-fill me-1"></i><%= safe(email) %></span>
                            <span class="small-muted">|</span>
                            <span class="small-muted"><i class="bi bi-phone-fill me-1"></i><%= safe(mobile) %></span>
                        </div>
                    </div>

                    <div class="text-end d-none d-md-block">
                        <a class="btn btn-primary" href="#" data-bs-toggle="modal" data-bs-target="#editModal"><i class="bi bi-pencil-square me-1"></i>Edit Profile</a>
                        <div class="small-muted mt-1">Member since <strong><%= tryGetString(userObj,"getUserDate","getCreatedAt") %></strong></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- left: details -->
        <div class="col-lg-8">
            <div class="card p-4 profile-card">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Profile Details</h5>
                    <button class="btn btn-sm btn-outline-primary d-md-none" data-bs-toggle="modal" data-bs-target="#editModal">
                        <i class="bi bi-pencil"></i> Edit
                    </button>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="small-muted">Full Name</div>
                        <div class="fw-medium fs-6"><%= safe(fname) %> <%= safe(lname) %></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="small-muted">Email</div>
                        <div class="fw-medium fs-6"><%= safe(email) %></div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <div class="small-muted">Mobile</div>
                        <div class="fw-medium fs-6"><%= safe(mobile) %></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="small-muted">Blood Group</div>
                        <div class="fw-medium fs-6"><%= safe(blood) %></div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <div class="small-muted">City</div>
                        <div class="fw-medium fs-6"><%= safe(city) %></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="small-muted">State</div>
                        <div class="fw-medium fs-6"><%= safe(state) %></div>
                    </div>
                </div>
            </div>

            <div class="mt-3">
                <div class="card p-3 profile-card">
                    <h6 class="mb-2">Safety & Account</h6>
                    <p class="small-muted mb-0">For security, change your password from the Account settings page. Keep your contact details up to date so donors can reach you.</p>
                </div>
            </div>
        </div>

        <!-- right: stats / actions -->
        <div class="col-lg-4">
            <div class="card p-3 profile-card text-center">
                <div class="mb-3">
                    <h6 class="mb-0">Quick Actions</h6>
                    <small class="small-muted">Manage profile</small>
                </div>

                <a class="btn btn-outline-primary w-100 mb-2" href="#" data-bs-toggle="modal" data-bs-target="#editModal"><i class="bi bi-pencil-fill me-2"></i>Edit Profile</a>
                <a class="btn btn-outline-secondary w-100 mb-2" href="changePassword.jsp"><i class="bi bi-key-fill me-2"></i>Change Password</a>
                <a class="btn btn-outline-danger w-100" href="deleteAccount.jsp"><i class="bi bi-trash-fill me-2"></i>Delete Account</a>
            </div>

            <div class="card p-3 profile-card mt-3">
                <h6 class="mb-2">Contact Visibility</h6>
                <p class="small-muted">Your mobile is visible to verified users only.</p>
                <div class="d-flex gap-2">
                    <button class="btn btn-sm btn-success flex-fill">Make Visible</button>
                    <button class="btn btn-sm btn-outline-secondary flex-fill">Hide</button>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- EDIT MODAL -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <form class="modal-content" action="EditProfileServlet" method="post" enctype="multipart/form-data" id="editProfileForm">
            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-person-fill me-2"></i>Edit Profile</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <div class="row g-3">
                    <div class="col-md-4 text-center">
                        <img id="previewImg" src="<%= avatar %>" alt="Preview" class="avatar mb-3">
                        <div class="small-muted mb-2">Profile image preview</div>
                        <div class="d-grid">
                            <label class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-upload me-1"></i>Choose Image
                                <input id="imageInput" type="file" name="image" accept="image/*" hidden>
                            </label>
                            <button type="button" class="btn btn-link btn-sm text-danger mt-2" id="removeImageBtn">Remove</button>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <div class="row g-2">
                            <div class="col-md-6">
                                <label class="form-label">First Name</label>
                                <input type="text" name="fname" class="form-control" value="<%= safe(fname) %>" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Last Name</label>
                                <input type="text" name="lname" class="form-control" value="<%= safe(lname) %>" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" value="<%= safe(email) %>" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Mobile</label>
                                <input type="text" name="mobile" class="form-control" value="<%= safe(mobile) %>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">City</label>
                                <input type="text" name="city" class="form-control" value="<%= safe(city) %>">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">State</label>
                                <input type="text" name="state" class="form-control" value="<%= safe(state) %>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Blood Group</label>
                                <input type="text" name="bloodGroup" class="form-control" value="<%= safe(blood) %>">
                            </div>

                            <div class="col-md-12 text-end mt-2">
                                <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-success">Save changes</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- modal-body -->
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // image preview & remove
    const imageInput = document.getElementById('imageInput');
    const previewImg = document.getElementById('previewImg');
    const removeBtn = document.getElementById('removeImageBtn');

    imageInput && imageInput.addEventListener('change', (e) => {
        const f = e.target.files[0];
        if (!f) return;
        const url = URL.createObjectURL(f);
        previewImg.src = url;
    });

    removeBtn && removeBtn.addEventListener('click', () => {
        imageInput.value = "";
        // fallback preview to original (server avatar)
        previewImg.src = "<%= avatar %>";
    });

    // keep modal open on validation errors: (server sets msg and redirect so normally it's fine)
    // optional client-side validation can be added here

    // accessible focus: open modal if user clicked edit & was redirected with ?openEdit=1 (optional)
    (function() {
        const urlParams = new URLSearchParams(location.search);
        if (urlParams.get('openEdit') === '1') {
            const modal = new bootstrap.Modal(document.getElementById('editModal'));
            modal.show();
        }
    })();
</script>
</body>
</html>
